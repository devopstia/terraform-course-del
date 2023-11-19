## Amazon EKS Custom AMIs
https://github.com/aws-samples/amazon-eks-custom-amis



https://github.com/jenkins-infra/packer-images
https://github.com/devopstf/packer-aws-sample
## links
- https://developer.hashicorp.com/packer/plugins/builders/amazon/ebs
- https://developer.hashicorp.com/packer/docs/templates/hcl_templates/onlyexcept

## What is Packer?
Packer is easy to use and automates the creation of any type of machine image.

## Key Packer Terminologies
- **Artifacts** are the results of a single build, and are usually a set of IDs or files to represent a machine image. Every builder produces a single artifact. As an example, in the case of the Amazon EC2 builder, the artifact is a set of AMI IDs (one per region). For the VMware builder, the artifact is a directory of files comprising the created virtual machine.

- **Builds** are a single task that eventually produces an image for a single platform. Multiple builds run in parallel. Example usage in a sentence: “The Packer build produced an AMI to run our web application.” Or: “Packer is running the builds now for VMware, AWS, and VirtualBox.”
Builders are components of Packer that are able to create a machine image for a single platform. 

- **Builders** read in some configuration and use that to run and generate a machine image. A builder is invoked as part of a build in order to create the actual resulting images. Example builders include VirtualBox, VMware, and Amazon EC2. Builders can be created and added to Packer in the form of plugins.

- **Commands** are sub-commands for the packer program that perform some job. An example command is “build”, which is invoked as packer build. Packer ships with a set of commands out of the box in order to define its command-line interface.
Post-processors are components of Packer that take the result of a builder or another post-processor and process that to create a new artifact. Examples of post-processors are compress to compress artifacts, upload to upload artifacts, etc.

- **Provisioners** are components of Packer that install and configure software within a running machine prior to that machine being turned into a static image. They perform the major work of making the image contain useful software. Example provisioners include shell scripts, Chef, Puppet, etc.

- **Templates** are JSON files which define one or more builds by configuring the various components of Packer. Packer is able to read a template and use that information to create multiple machine images in parallel.

## Packer commands
- `packer --version` : to check the version
- `packer init` : to download the plugin
- `packer fmt` : to format the code
- `packer validate` : this will check if the configuration files are correct
- `packer build` : this will build the template and create the image
- `inspect` : see components of a template

- packer init .
- packer fmt .
- packer validate .
- packer build .

## Practice packer commands with template

```t
# https://developer.hashicorp.com/packer/tutorials/aws-get-started/aws-get-started-build-image

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-ubuntu-aws-{{timestamp}}"
#   ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}
```


## packer core component
- source
- provisioner
- builders
- variables
- communicators
- post-processors

**source block**
```t
source "amazon-ebs" "ubuntu" {
  ami_name      = "packer-ubuntu-aws-{{timestamp}}"
#   ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}
```

**File provisioner and shell block**
- This blocks are run at build time
- This is the block that have all the instructions to create the image
```t
build {
  name    = "packer-wordpress-tutorialinux-aws"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    scripts = [
      # base install
      "scripts/ami_config_script.sh"
    ]
  }
  provisioner "file" {
    source = "./config/nginx.conf"
    destination = "~/nginx.conf"
  }
  provisioner "file" {
    source = "./config/wordpress_nginx.conf"
    destination = "~/wordpress_nginx.conf"
  }
  provisioner "file" {
    source = "config/wordpress_phpfpm.conf"
    destination = "~/phppool.conf"
  }
  provisioner "shell" {
    # copying files in two steps because of packer/sudo limitations
    inline = [
      "sudo mv ~/nginx.conf /etc/nginx/nginx.conf",
      "sudo mv ~/wordpress_nginx.conf /etc/nginx/conf.d/tutorialinux.conf",
      "sudo mv ~/phppool.conf /etc/php/8.1/fpm/pool.d/tutorialinux.conf",
    ]
  }
  provisioner "shell" {
    scripts = [
      # final WordPress application setup
      "scripts/wordpress_site_setup.sh"
    ]
  }
}
```

**post-processors**
- It can be used to specify what to do after the build such as cleaning up some file
```t
build {
  name    = "packer-wordpress-tutorialinux-aws"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    scripts = [
      source = "scripts/wordpress_site_setup.sh"
      destination = "/tmp/wordpress_site_setup.sh"
    ]
  }
  provisioner "shell" {
    inline = [
      "sudo bash /tmp/wordpress_site_setup.sh",
    ]
  }
  post-processors "shell-local" {
    inline = [
      "rm -rf /tmp/wordpress_site_setup.sh"
    ]
  }
}
```

**communicators**
- communicators are the machanism that packer uses to upload the final artifact.
- communicators are configure within the source blockin the template. We have 3 types of communicators:
  - SSH: this is the default communicator in Linx on port `22`
  - WinRM: this is for windows on port `5985`
  - docker exec: this for docker

## VPC
- packer will launch an instance in the default vpc by default to build the image. if you do not have the default VPC, make sure that you specify the VPC ID that you want packer to use

## Packer template
- templates in packer are like terraform configuration file
- Packer templates support 2 format:
  - HLC: This is the new format
  - JSON: this was the old format


## Builders
- Builders are like providers in terraform
- Builders are responsable for creating machine images
- popular builders
  - AWS builde
  - Azure builder
  - GCP builder
  - VMware builder
  - Virtualbox builder
  - docker builder
  - Null builder
  - Vagrant
  - Microsoft
  - Digital Ocean


##  tags, variables, vpc and template
```t
variable "image_name" {
  type    = string
  default = "packer-ubuntu-aws"
}

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name = "${var.image_name}-{{timestamp}}"
  #   ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  subnet_id    = "subnet-096d45c28d9fb4c14"
  tags = {
    "Name"        = "${var.image_name}"
    "Environment" = "Production"
    "OS_Version"  = "Ubuntu 20.04"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
  vpc_id = "vpc-068852590ea4b093b"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
}
```


