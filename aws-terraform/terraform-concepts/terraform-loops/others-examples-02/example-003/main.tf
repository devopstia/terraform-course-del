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

variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "t2.micro", "t2.micro"]
}

resource "aws_instance" "example" {
  for_each               = { for idx, type in var.instance_types : idx => type }
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = each.value
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  root_block_device {
    volume_size = "10"
  }
  tags = {
    # Name      = "vm-${each.key}-${each.value}"
    # Name = "vm-${each.value}-${each.key}"
    Name      = "vm-${each.key}"
    Create_By = "Terraform"
  }
}

