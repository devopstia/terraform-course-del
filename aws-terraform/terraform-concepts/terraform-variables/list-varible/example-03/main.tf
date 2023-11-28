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
  description = "List of AWS EC2 instance types"
  type        = list(string)
  default = [
    "t2.micro",
    "t2.small",
    "t2.medium",
    "m5.large",
    "m5.xlarge"
  ]
}

resource "aws_instance" "example" {
  ami = "ami-0fc5d935ebf8bc3bc"
  # This will use the first instance type in the list
  instance_type          = var.instance_types[0]
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  root_block_device {
    volume_size = "10"
  }
  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}
