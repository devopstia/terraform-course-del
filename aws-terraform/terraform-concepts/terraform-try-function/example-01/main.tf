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
  type = map(string)
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

# Create the EC2 instance using the map values
resource "aws_instance" "vm" {
  ami                    = try(var.instance_params["ami"], "ami-0fc5d935ebf8bc3bc")
  instance_type          = try(var.instance_params["instance_type"], "t2.micro")
  key_name               = try(var.instance_params["key_name"], "terraform-aws")
  vpc_security_group_ids = try(var.instance_params["vpc_security_group_ids"], ["sg-0c51540c60857b7ed"])
  subnet_id              = try(var.instance_params["subnet_id"], "subnet-096d45c28d9fb4c14")

  root_block_device {
    volume_size = try(var.instance_params["volume_size"], "10")
  }

  tags = try(var.tags, {
    Name      = "vm"
    Create_By = "Terraform"
  })
}


