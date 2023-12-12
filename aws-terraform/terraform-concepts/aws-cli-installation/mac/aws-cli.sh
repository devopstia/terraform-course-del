#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Update Homebrew and install AWS CLI
echo "Updating Homebrew..."
brew update
echo "Installing AWS CLI..."
brew install awscli

# Verify the AWS CLI installation
echo "AWS CLI installation completed."
aws --version
