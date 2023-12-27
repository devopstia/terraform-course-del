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

data "terraform_remote_state" "vpc_state" {
  backend = "s3"
  config = {
    bucket = "2560-dev-del-backend"
    key    = "vpc-test/terraform.tfstate"
    region = "us-east-1"
  }
}

terraform {
  backend "s3" {
    bucket = "2560-dev-del-backend"
    # dynamodb_table = "2560-dev-del-backend-lock"
    key    = "ec2-test/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  subnet_id              = data.terraform_remote_state.vpc_state.outputs.subnet1_id
  root_block_device {
    volume_size = "10"
  }
  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}
