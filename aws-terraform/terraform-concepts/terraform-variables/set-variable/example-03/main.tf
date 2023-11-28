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


variable "allowed_ip_addresses" {
  type = set(string)
  default = [
    "192.168.1.1",
    "10.0.0.0/24",
    "203.0.113.0/24"
  ]
}

resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Example Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_addresses
  }
}
