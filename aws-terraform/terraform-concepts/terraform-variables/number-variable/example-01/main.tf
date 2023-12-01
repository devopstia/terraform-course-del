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

# Define a number variable for the count of instances
variable "example_number" {
  description = "Number of AWS instances to create"
  type        = number
  default     = 2 # You can change the default value as needed
}

resource "aws_instance" "example" {
  count = var.example_number # Use the variable to determine the number of instances

  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = "vm-${count.index + 1}" # Create unique instance names
    Create_By = "Terraform"
  }
}

