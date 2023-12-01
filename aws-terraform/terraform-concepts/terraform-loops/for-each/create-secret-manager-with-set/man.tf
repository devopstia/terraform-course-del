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

provider "aws" {
  region = "us-east-1"
}

variable "aws-secret-string" {
  type = set(string)
  default = [
    "jenkins",
    "splunk_key",
    "aws-key",
    "elk-key"
  ]
}

resource "aws_secretsmanager_secret" "example" {
  for_each                = var.aws-secret-string
  name                    = each.value
  recovery_window_in_days = 0
  tags = {
    "Terraform" = "true"
    "Project"   = "MAM"
  }
}



