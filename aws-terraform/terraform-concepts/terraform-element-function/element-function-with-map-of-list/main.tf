terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "vm" {
  type = map(list(string))
  default = {
    region                 = ["us-east-1"]
    availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
    instance_types         = ["t2.micro", "t2.small", "t2.medium"]
    subnet_id              = ["subnet-096d45c28d9fb4c14"]
    ami                    = ["ami-0fc5d935ebf8bc3bc"]
    vpc_security_group_ids = ["sg-0c51540c60857b7ed", "sg-00db218863d2b2a67"]
    key_name               = ["terraform-aws"]
    volume_size            = ["10"]
  }
}

provider "aws" {
  region = element(var.vm["region"], 0)
}

resource "aws_instance" "example" {
  ami           = element(var.vm["ami"], 0)
  instance_type = element(var.vm["instance_types"], 2)
  key_name      = element(var.vm["key_name"], 0)
  vpc_security_group_ids = [
    element(var.vm["vpc_security_group_ids"], 0),
    element(var.vm["vpc_security_group_ids"], 1)
  ]
  subnet_id         = element(var.vm["subnet_id"], 0)
  availability_zone = element(var.vm["availability_zones"], 0)

  root_block_device {
    volume_size = element(var.vm["volume_size"], 0)
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}

