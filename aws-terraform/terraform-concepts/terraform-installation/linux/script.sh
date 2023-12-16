#!/bin/bash

# List of Terraform versions and corresponding binary names
terraform_versions=("0.12.30" "0.13.0" "0.14.0" "1.0.0" "1.2.6" "1.0.0")
terraform_bin_names=("tf12" "tf13" "tf14" "tf1" "tf126" "terraform")

# Ensure that the required packages are installed
apt update
apt install -y wget unzip

# Loop through the versions and install each one with the corresponding binary name
for i in "${!terraform_versions[@]}"; do
    version="${terraform_versions[$i]}"
    binary_name="${terraform_bin_names[$i]}"
    echo "Installing Terraform version $version as $binary_name..."
    wget -q "https://releases.hashicorp.com/terraform/$version/terraform_${version}_linux_amd64.zip" -O terraform.zip
    unzip -q terraform.zip
    mv terraform "/usr/local/bin/$binary_name"
    rm terraform.zip
    echo "Installed Terraform version $version as $binary_name."
done

# Verify the installed versions
echo "Installed Terraform versions:"
tf12 version
tf13 version
tf14 version
tf1 version
tf126 version
terraform version
