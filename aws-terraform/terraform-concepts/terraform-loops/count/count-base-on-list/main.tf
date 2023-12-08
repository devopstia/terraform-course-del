terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-096d45c28d9fb4c14",
    "subnet-05f285a35173783b0",
    "subnet-0cf0e3c5a513134bd",
  ]
}


resource "aws_instance" "example" {
  count = length(var.subnet_ids)

  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = var.subnet_ids[count.index]

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = "vm-${count.index + 1}"
    Create_By = "Terraform"
  }
}
