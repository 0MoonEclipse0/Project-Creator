# Project Creator

This project is a programming project creator it currently supports following programming languages: C, C++ Rust Python X86_64 Java, Javascript, Go

## Installation

### Please Note that:

Currently this project only supports linux and you need to have a systemwide installation of GNU make

### Install.sh

For the installation just Run the install.sh script.

### Systemwide manual Install

To install copy the sh file into the /usr/bin directory:

`sudo cp new.sh /usr/bin`

### Rootless non systemwide manual Install

1. create a directory for the program.

   `mkdir ~/project-creator`

2. add an alias to the .bashrc file ( add the following code to the .bashrc file ).

   `alias new=~/project-creator/new.sh`

## Usage

To use just run the new command it needs the following flag format:

`new -n <name> -t <type> [--editor <editor>]`

The -n flag stands for the name of the project.
The -t flag stands for the type of the project so the programming language that is used.
The --editor flag is optional and stands for the editor that is going to be used to open the project

Please Note that every project ( exept Rust ) can be run just by running

`make`

To run Rust Projects just run

`cargo run`
