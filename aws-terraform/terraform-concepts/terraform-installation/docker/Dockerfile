# Use Alpine Linux as the base image
FROM alpine:latest

# Update the package index and install necessary packages
RUN apk --update add \
    wget \
    curl \
    vim \
    unzip \
    git \
    python3 \
    py3-pip \
    && rm -rf /var/cache/apk/*

# Install AWS CLI using pip
RUN pip3 install awscli

# Install Terraform
ENV TERRAFORM_VERSION 1.0.0
WORKDIR /tmp
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm -f terraform terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Terragrunt
ENV TERRAGRUNT_VERSION v0.31.0
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt
