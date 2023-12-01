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
  type = list(string)
  default = [
    "jenkins",
    "splunk_key",
    "argocd",
    "aws-key",
    "elk-key"
  ]
}

resource "aws_secretsmanager_secret" "example" {
  count                   = length(var.aws-secret-string)
  name                    = var.aws-secret-string[count.index]
  recovery_window_in_days = 0
  tags = {
    "Terraform" = "true"
    "Project"   = "DEL"
  }
}



