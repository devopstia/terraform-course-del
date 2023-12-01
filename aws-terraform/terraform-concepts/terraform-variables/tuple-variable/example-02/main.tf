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

variable "ec2_instance_config" {
  description = "Configuration for an EC2 instance"
  type = tuple([
    string,
    string,
    number,
    number,
    map(string),
    list(string)
    ]
  )
  default = [
    "t2.micro",
    "ami-0fc5d935ebf8bc3bc",
    1,
    20,
    {
      "Name"           = "vm"
      "id"             = "2560"
      "owner"          = "DevOps Easy Learning"
      "teams"          = "DEL"
      "environment"    = "development"
      "project"        = "del"
      "create_by"      = "Terraform"
      "cloud_provider" = "aws"
    },
    [
      "sg-0c51540c60857b7ed", "sg-0c51540c60857b7ed"
    ]
  ]
}

resource "aws_instance" "example" {
  count                  = var.ec2_instance_config[2]
  ami                    = var.ec2_instance_config[1]
  instance_type          = var.ec2_instance_config[0]
  key_name               = "terraform-aws"
  vpc_security_group_ids = var.ec2_instance_config[5]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  root_block_device {
    volume_size = var.ec2_instance_config[3]
  }
  tags = var.ec2_instance_config[4]
}

output "instance_public_ips" {
  value = aws_instance.example[*].public_ip
}
