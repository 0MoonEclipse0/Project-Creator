#!/bin/bash

# Initialize variables
type=""
name=""
editor=""

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -t) type="$2"; shift ;;
        -n) name="$2"; shift ;;
        --editor) editor="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Check if required parameters are set
if [ -z "$type" ] || [ -z "$name" ]; then
    echo "Usage: $0 -t <type> -n <name> [--editor <editor>]"
    exit 1
fi

# Print the variables
echo "Creating project of type: $type and name: $name"

# Perform actions based on type
if [ "$type" = "c" ]; then
    mkdir -p "$name/src" "$name/build"
    touch "$name/src/main.c" "$name/Makefile"
    
    # Add content to src/main.c
    cat <<EOL > "$name/src/main.c"
#include <stdio.h>

/* Example C script */

int main() {
    printf("Hello, world!\\n");
    return 0;
}
EOL

    # Add content to Makefile
    cat <<EOL > "$name/Makefile"
CC=gcc
CFLAGS=-I.
LIBS=

${name}: ${name}.o
\t\$(CC) -o ${name} ${name}.o \$(CFLAGS) \$(LIBS)

${name}.o: src/main.c
\t\$(CC) -c src/main.c \$(CFLAGS)
EOL

elif [ "$type" = "rust" ]; then
    cargo new "$name"

elif [ "$type" = "cpp" ] || [ "$type" = "c++" ]; then
    mkdir -p "$name/src" "$name/build"
    touch "$name/src/main.cpp" "$name/Makefile"
    
    # Add content to src/main.cpp
    cat <<EOL > "$name/src/main.cpp"
#include <iostream>

/* Example C++ script */

int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
}
EOL

    # Add content to Makefile
    cat <<EOL > "$name/Makefile"
CC=g++
CFLAGS=-I.
LIBS=

${name}: ${name}.o
\t\$(CC) -o ${name} ${name}.o \$(CFLAGS) \$(LIBS)

${name}.o: src/main.cpp
\t\$(CC) -c src/main.cpp \$(CFLAGS)
EOL

elif [ "$type" = "py" ] || [ "$type" = "python" ] || [ "$type" = "Python" ]; then
    mkdir -p "$name/src" "$name/build"
    touch "$name/src/main.py"
    
    # Add content to src/main.py
    cat <<EOL > "$name/src/main.py"
# Example Python script

print("Hello, World")
EOL

elif [ "$type" = "asm" ] || [ "$type" = "x86_64" ] || [ "$type" = "ASM" ] || [ "$type" = "ASM-x86_64" ] || [ "$type" = "x86_64-ASM" ]; then
    mkdir -p "$name/src" "$name/build"
    touch "$name/src/main.asm" "$name/Makefile"
    
    # Add content to src/main.asm
    cat <<EOL > "$name/src/main.asm"
global _start

; Simple x86_64 script

section .text

_start:
  mov rax, 1        ; write(
  mov rdi, 1        ;   STDOUT_FILENO,
  mov rsi, msg      ;   "Hello, world!\n",
  mov rdx, msglen   ;   sizeof("Hello, world!\n")
  syscall           ; );

  mov rax, 60       ; exit(
  mov rdi, 0        ;   EXIT_SUCCESS
  syscall           ; );

section .rodata
  msg: db "Hello, world!", 10
  msglen: equ $ - msg
EOL

    # Add content to Makefile
    cat <<EOL > "$name/Makefile"
ASM=nasm
ASMFLAGS=-f elf64

${name}: ${name}.o
\tld -o ${name} ${name}.o

${name}.o: src/main.asm
\t\$(ASM) \$(ASMFLAGS) src/main.asm -o ${name}.o
EOL

elif [ "$type" = "java" ]; then
    mkdir -p "$name/src" "$name/build"
    touch "$name/src/Main.java" "$name/Makefile"
    
    # Add content to src/Main.java
    cat <<EOL > "$name/src/Main.java"
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
EOL

    # Add content to Makefile
    cat <<EOL > "$name/Makefile"
JAVAC=javac
JAVA=java
SRC=src
BIN=build

all: \$(BIN)/Main.class

\$(BIN)/Main.class: \$(SRC)/Main.java
\tmkdir -p \$(BIN)
\t\$(JAVAC) -d \$(BIN) \$(SRC)/Main.java

run: all
\t\$(JAVA) -cp \$(BIN) Main

clean:
\trm -rf \$(BIN)
EOL

elif [ "$type" = "js" ] || [ "$type" = "javascript" ]; then
    mkdir -p "$name/src" "$name/build"
    touch "$name/src/main.js" "$name/Makefile"
    
    # Add content to src/main.js
    cat <<EOL > "$name/src/main.js"
// Example JavaScript script

console.log("Hello, World!");
EOL

elif [ "$type" = "go" ]; then
    mkdir -p "$name/src" "$name/build"
    touch "$name/src/main.go" "$name/Makefile"
    
    # Add content to src/main.go
    cat <<EOL > "$name/src/main.go"
package main

import "fmt"

/* Example Go script */

func main() {
    fmt.Println("Hello, World!")
}
EOL

    # Add content to Makefile
    cat <<EOL > "$name/Makefile"
GO=go

build: src/main.go
\t\$(GO) build -o build/${name} src/main.go

run: build
\t./build/${name}

clean:
\trm -f build/${name}
EOL

else
    echo "Unsupported project type: $type"
    exit 1
fi

# Open project in the specified editor, if provided
if [ -n "$editor" ]; then
    $editor "$name" &
fi
