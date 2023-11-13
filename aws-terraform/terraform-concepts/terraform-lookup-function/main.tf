terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "vm" {
  type = map(string)
  default = {
    region                 = "us-east-1"
    availability_zones     = "us-east-1a"
    instance_types         = "t2.micro"
    subnet_id              = "subnet-096d45c28d9fb4c14"
    ami                    = "ami-0fc5d935ebf8bc3bc"
    vpc_security_group_ids = "sg-0c51540c60857b7ed"
    key_name               = "jenkins-key"
    volume_size            = "10"
  }
}

provider "aws" {
  region = lookup(var.vm, "region", "us-east-1")
}

resource "aws_instance" "example" {
  ami           = lookup(var.vm, "ami", "ami-0fc5d935ebf8bc3bc")
  instance_type = lookup(var.vm, "instance_types", "t2.micro")
  key_name      = lookup(var.vm, "key_name", "jenkins-key")
  vpc_security_group_ids = [
    lookup(var.vm, "vpc_security_group_ids", "")
  ]
  subnet_id         = lookup(var.vm, "subnet_id", "subnet-096d45c28d9fb4c14")
  availability_zone = lookup(var.vm, "availability_zones", "us-east-1a")

  root_block_device {
    volume_size = lookup(var.vm, "volume_size", "10")
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}

# ============================================

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "vm" {
  type = map(string)
  default = {
    region                 = "us-east-1"
    availability_zones     = "us-east-1a"
    instance_types         = "t2.micro"
    subnet_id              = "subnet-096d45c28d9fb4c14"
    ami                    = "ami-0fc5d935ebf8bc3bc"
    vpc_security_group_ids = "sg-0c51540c60857b7ed"
    key_name               = "jenkins-key"
    volume_size            = "10"
  }
}

provider "aws" {
  region = lookup(var.vm, "region", null)
}

resource "aws_instance" "example" {
  ami           = lookup(var.vm, "ami", null)
  instance_type = lookup(var.vm, "instance_types", null)
  key_name      = lookup(var.vm, "key_name", null)
  vpc_security_group_ids = [
    lookup(var.vm, "vpc_security_group_ids", null)
  ]
  subnet_id         = lookup(var.vm, "subnet_id", null)
  availability_zone = lookup(var.vm, "availability_zones", null)

  root_block_device {
    volume_size = lookup(var.vm, "volume_size", null)
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}

# ===================================================================
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "vm" {
  type = map(string)
}

provider "aws" {
  region = lookup(var.vm, "region")
}

resource "aws_instance" "example" {
  ami           = lookup(var.vm, "ami")
  instance_type = lookup(var.vm, "instance_types")
  key_name      = lookup(var.vm, "key_name")
  vpc_security_group_ids = [
    lookup(var.vm, "vpc_security_group_ids")
  ]
  subnet_id         = lookup(var.vm, "subnet_id")
  availability_zone = lookup(var.vm, "availability_zones")

  root_block_device {
    volume_size = lookup(var.vm, "volume_size")
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}
