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

# Define a map of objects for multiple instances
variable "instances" {
  type = map(object({
    ami                    = string
    instance_type          = string
    key_name               = string
    vpc_security_group_ids = list(string)
    subnet_id              = string
    volume_size            = string
    tags                   = map(string)
  }))
  default = {
    example_instance1 = {
      ami                    = "ami-0fc5d935ebf8bc3bc"
      instance_type          = "t2.micro"
      key_name               = "terraform-aws"
      vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
      subnet_id              = "subnet-096d45c28d9fb4c14"
      volume_size            = "10"
      tags = {
        Name      = "example-instance1"
        Create_By = "Terraform"
      }
    },
    example_instance2 = {
      ami                    = "ami-0fc5d935ebf8bc3bc"
      instance_type          = "t2.micro"
      key_name               = "terraform-aws"
      vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
      subnet_id              = "subnet-096d45c28d9fb4c14"
      volume_size            = "20"
      tags = {
        Name      = "example-instance2"
        Create_By = "Terraform"
      }
    },
    # Add more instances as needed
  }
}

# Create AWS instances based on the map of objects
resource "aws_instance" "vm" {
  for_each = var.instances

  ami                    = var.instances[each.key].ami
  instance_type          = var.instances[each.key].instance_type
  key_name               = var.instances[each.key].key_name
  vpc_security_group_ids = var.instances[each.key].vpc_security_group_ids
  subnet_id              = var.instances[each.key].subnet_id

  root_block_device {
    volume_size = var.instances[each.key].volume_size
  }

  tags = var.instances[each.key].tags
}
