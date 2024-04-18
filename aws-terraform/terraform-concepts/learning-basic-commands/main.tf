terraform {
  required_version = "~> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = "terraform_aws"
  vpc_security_group_ids = ["sg-01029671868439d58"]
  subnet_id              = "subnet-0cb3c71f40d73c4dc"
  root_block_device {
    volume_size = "10"
  }
  tags = {
    Name      = "virtual machine"
    Create_By = "Terraform"
  }
}
