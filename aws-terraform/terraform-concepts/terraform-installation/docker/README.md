## terraform-installation
```
docker build -t terraform .
docker run --rm -it  terraform:latest /bin/sh
docker run --rm -it -v "$PWD":"/terraform" terraform:latest /bin/sh
terraform --version
terragrunt --version
aws --version
```
## alpine image do not accept /bin/sh 

you will run into this error if you us /bin/bash as CMD
```
root@tia@EK-TECH-SERVER02:/student_home# docker run --rm -it  terraform:latest /bin/bash
docker: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: "/bin/no such file or directory: unknown.

root@tia@EK-TECH-SERVER02:/student_home# docker run --rm -it  terraform:latest bash
docker: Error response from daemon: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: exec: "/bin/no such file or directory: unknown.
```

```Dockerfile
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
CMD ["/bin/bash"]
```