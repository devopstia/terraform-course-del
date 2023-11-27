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

variable "instance_configurations" {
  type = list(object({
    ami                = string
    instance_type      = string
    key_name           = string
    subnet_id          = string
    security_group_ids = list(string)
    tags               = map(string)
  }))
  default = [
    {
      ami                = "ami-0fc5d935ebf8bc3bc"
      instance_type      = "t2.micro"
      key_name           = "terraform-aws"
      subnet_id          = "subnet-096d45c28d9fb4c14"
      security_group_ids = ["sg-12345678"]
      tags = {
        Name      = "vm1"
        Create_By = "Terraform"
      }
    },
    {
      ami                = "ami-0fc5d935ebf8bc3bc"
      instance_type      = "m4.large"
      key_name           = "dev-key"
      subnet_id          = "subnet-096d45c28d9fb4c15"
      security_group_ids = ["sg-87654321"]
      tags = {
        Name      = "vm2"
        Create_By = "Terraform"
      }
    },
    {
      ami                = "ami-0fc5d935ebf8bc3bc"
      instance_type      = "c5.xlarge"
      key_name           = "admin-key"
      subnet_id          = "subnet-096d45c28d9fb4c16"
      security_group_ids = ["sg-99999999"]
      tags = {
        Name      = "vm3"
        Create_By = "Terraform"
      }
    }
  ]
}

resource "aws_instance" "example" {
  count = length(var.instance_configurations)

  ami                    = var.instance_configurations[count.index].ami
  instance_type          = var.instance_configurations[count.index].instance_type
  key_name               = var.instance_configurations[count.index].key_name
  subnet_id              = var.instance_configurations[count.index].subnet_id
  vpc_security_group_ids = var.instance_configurations[count.index].security_group_ids

  tags = var.instance_configurations[count.index].tags
}

