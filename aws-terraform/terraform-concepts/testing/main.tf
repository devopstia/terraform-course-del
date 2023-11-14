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
    instance_type = string
    key_name      = string
  }))
  default = [
    {
      instance_type = "t2.micro"
      key_name      = "jenkins-key"
    },
    {
      instance_type = "m4.large"
      key_name      = "dev-key"
    },
    {
      instance_type = "c5.xlarge"
      key_name      = "admin-key"
    }
  ]
}

resource "aws_instance" "example" {
  count = length(var.instance_configurations)

  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = var.instance_configurations[count.index].instance_type
  key_name               = var.instance_configurations[count.index].key_name
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = "vm-${count.index + 1}"
    Create_By = "Terraform"
  }
}
