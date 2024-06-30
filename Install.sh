#!/bin/bash

echo "Starting Installation"
echo "Type 1 to install systemwide. Type 2 to install rootless."

# Read user input
read -p "Enter your choice (1 or 2): " input

# Check if input is valid
if [ "$input" = "1" ]; then
    echo "Installing systemwide..."
    sudo cp new.sh /usr/bin
    echo "Installation completed systemwide."

elif [ "$input" = "2" ]; then
    echo "Installing rootless..."
    mkdir -p ~/project-creator
    cp new.sh ~/project-creator
    # Add alias to .bashrc if not already present
    if ! grep -q "alias new=" ~/.bashrc; then
        echo "alias new='~/project-creator/new.sh'" >> ~/.bashrc
        echo "Alias added to .bashrc. Please restart your terminal or run 'source ~/.bashrc' to apply changes."
    else
        echo "Alias already exists in .bashrc."
    fi
    echo "Installation completed rootless."

else
    echo "Invalid choice. Exiting."
    exit 1
fi