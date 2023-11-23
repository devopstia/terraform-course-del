# Use an appropriate base image, for example, Ubuntu 20.04
FROM ubuntu:20.04

# Update the package list and install necessary packages
RUN apt-get update -y && \
    apt-get install -y \
    git \
    wget \
    curl \
    vim \
    unzip

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Install Terraform
ENV TERRAFORM_VERSION 1.0.0
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Terragrunt
ENV TERRAGRUNT_VERSION v0.31.0
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 && \
    chmod +x terragrunt_linux_amd64 && \
    mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

# Switch to the 'terraform' user
WORKDIR /home/terraform

# Set the default command to start a shell session
CMD ["/bin/bash"]
