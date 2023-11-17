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


variable "create_instance" {
  description = "Set to true to create the EC2 instance, false to skip creation."
  type        = bool
  default     = true # Default to create the instance.
}

variable "instance_count" {
  description = "Number of instances to create if 'create_instance' is true."
  type        = number
  default     = 1 # Default to create one instance.
}

variable "instance_name" {
  description = "Name for the EC2 instance."
  type        = string
  default     = "vm"
}

resource "aws_instance" "example" {
  count = var.create_instance ? var.instance_count : 0 # Conditionally create the instance based on 'create_instance' variable.

  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = var.create_instance ? "${var.instance_name}-${count.index + 1}" : null
    Create_By = var.create_instance ? "Terraform" : null
  }
}
