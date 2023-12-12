#!/bin/bash

# Update the package list
sudo apt update

# Install AWS CLI using the package manager
sudo apt install -y awscli

# Verify the AWS CLI installation
echo "AWS CLI installation completed."
aws --version
