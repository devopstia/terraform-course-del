terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "remote" {
    organization = "DEL-ORG"

    workspaces {
      name = "dev"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# resource "aws_instance" "app_server" {
#   ami           = "ami-052efd3df9dad4825"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "web02"
#   }
# }
