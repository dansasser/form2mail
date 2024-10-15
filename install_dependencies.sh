#!/bin/bash

# Define the directory for the virtual environment
VENV_DIR="venv"

# Function to check if a command exists
command_exists () {
    command -v "$1" >/dev/null 2>&1
}

# Check if python3 is installed
if ! command_exists python3; then
    echo "Python3 is not installed. Please install Python3 first."
    exit 1
fi

# Check if venv module is available (ensurepip checks if venv is installed)
if ! python3 -m venv --help > /dev/null 2>&1; then
    echo "The python3-venv package is not installed. Installing it now..."

    # Install python3-venv for virtual environment creation
    sudo apt update
    sudo apt install -y python3-venv

    # Re-check if venv is available after installation
    if ! python3 -m venv --help > /dev/null 2>&1; then
        echo "Failed to install the python3-venv package. Please install it manually."
        exit 1
    fi

    echo "python3-venv installed successfully."
fi

# Check if virtual environment exists; if not, create it
if [ ! -d "$VENV_DIR" ]; then
    echo "Virtual environment not found. Creating one..."
    python3 -m venv "$VENV_DIR"
    if [ $? -ne 0 ]; then
        echo "Failed to create virtual environment."
        exit 1
    fi
    echo "Virtual environment created successfully."
else
    echo "Virtual environment already exists."
fi

# Activate the virtual environment
if [ -f "$VENV_DIR/bin/activate" ]; then
    source "$VENV_DIR/bin/activate"
else
    echo "Activation script not found in the virtual environment. Please check if the virtual environment was created correctly."
    exit 1
fi

# Ensure pip is installed in the virtual environment
if ! command_exists pip; then
    echo "pip is not available in the virtual environment. Attempting to install it..."
    python3 -m ensurepip --upgrade
    if [ $? -ne 0 ]; then
        echo "Failed to install pip in the virtual environment."
        exit 1
    fi
    echo "pip installed successfully."
fi

# Check if requirements.txt exists
if [ ! -f requirements.txt ]; then
    echo "requirements.txt not found in the current directory."
    exit 1
fi

# Install dependencies from requirements.txt
while read -r requirement || [ -n "$requirement" ]; do
    # Skip empty lines and comments
    if [[ -z "$requirement" ]] || [[ "$requirement" == \#* ]]; then
        continue
    fi

    # Extract package name (handles version specs like 'package==1.0.0')
    package_name=$(echo "$requirement" | sed 's/[<>=!].*//')

    # Check if the package is already installed in the virtual environment
    if pip show "$package_name" &> /dev/null; then
        echo "$package_name is already installed."
    else
        echo "$package_name is not installed. Installing..."
        pip install "$requirement"
        if [ $? -eq 0 ]; then
            echo "$package_name installed successfully."
        else
            echo "Failed to install $package_name. Please check for errors."
            exit 1
        fi
    fi
done < requirements.txt

echo "All dependencies are satisfied and installed in the virtual environment."
echo "To activate the virtual environment, run 'source $VENV_DIR/bin/activate'."

# Start the Python app
echo "Starting the Python app using main.py..."
python3 main.py
