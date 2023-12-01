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

# Define a map to hold the instance parameters
variable "instance_params" {
  type = any
  default = {
    ami                    = "ami-0fc5d935ebf8bc3bc"
    instance_type          = "t2.micro"
    key_name               = "terraform-aws"
    vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
    subnet_id              = "subnet-096d45c28d9fb4c14"
    volume_size            = "10"
    tags = {
      Name      = "vm"
      Create_By = "Terraform"
    }
  }
}

# Create the EC2 instance using the map values
resource "aws_instance" "vm" {
  ami                    = var.instance_params["ami"]
  instance_type          = var.instance_params["instance_type"]
  key_name               = var.instance_params["key_name"]
  vpc_security_group_ids = var.instance_params["vpc_security_group_ids"]
  subnet_id              = var.instance_params["subnet_id"]

  root_block_device {
    volume_size = var.instance_params["volume_size"]
  }

  tags = var.instance_params["tags"]
}


