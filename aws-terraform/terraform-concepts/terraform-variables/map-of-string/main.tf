terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "instance_config" {
  description = "Instance configuration"
  type        = map(string)
  default = {
    ami                    = "ami-0fc5d935ebf8bc3bc"
    instance_type          = "t2.micro"
    key_name               = "terraform-aws"
    vpc_security_group_ids = "sg-0c51540c60857b7ed"
    subnet_id              = "subnet-096d45c28d9fb4c14"
    volume_size            = "10"
  }
}

variable "tags" {
  type = map(string)
  default = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}

resource "aws_instance" "example" {
  ami                    = var.instance_config["ami"]
  instance_type          = var.instance_config["instance_type"]
  key_name               = var.instance_config["key_name"]
  vpc_security_group_ids = [var.instance_config["vpc_security_group_ids"]]
  subnet_id              = var.instance_config["subnet_id"]
  root_block_device {
    volume_size = var.instance_config["volume_size"]
  }
  tags = var.tags
}

