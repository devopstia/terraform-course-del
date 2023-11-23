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

variable "instance_params" {
  type = map(object({
    ami                    = string
    instance_type          = string
    key_name               = string
    vpc_security_group_ids = list(string)
    subnet_id              = string
    volume_size            = number
    tags                   = map(string)
  }))
  default = {
    vm = {
      ami                    = "ami-0fc5d935ebf8bc3bc"
      instance_type          = "t2.micro"
      key_name               = null
      vpc_security_group_ids = []
      subnet_id              = null
      volume_size            = 10
      tags = {
        Name      = "vm"
        Create_By = "Terraform"
      }
    }
  }
}

resource "aws_instance" "vm" {
  ami                    = try(var.instance_params["ami"], "ami-0fc5d935ebf8bc3bc")
  instance_type          = try(var.instance_params["instance_type"], "t2.micro")
  key_name               = try(var.instance_params["key_name"], null)
  vpc_security_group_ids = try(var.instance_params["vpc_security_group_ids"], [])
  subnet_id              = try(var.instance_params["subnet_id"], null)

  root_block_device {
    volume_size = try(var.instance_params["volume_size"], 10)
  }

  tags = try(var.instance_params["tags"], {
    Name      = "vm",
    Create_By = "Terraform"
  })
}

