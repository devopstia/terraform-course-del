# Use Alpine Linux as the base image
FROM alpine:latest

# Install necessary packages
RUN apk update && \
    apk add --no-cache \
    aws-cli \
    git \
    wget \
    vim \
    && rm -rf /var/cache/apk/*

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip && \
    unzip terraform_1.0.0_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.0.0_linux_amd64.zip

# Install Terragrunt
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.31.0/terragrunt_linux_amd64 -O /usr/local/bin/terragrunt && \
    chmod +x /usr/local/bin/terragrunt

# Set the working directory to /terraform (you can change this as needed)
WORKDIR /terraform

# Entry point (you can customize this as needed)
CMD ["/bin/sh"]
