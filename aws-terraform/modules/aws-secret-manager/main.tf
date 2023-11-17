provider "aws" {
  region = var.aws_region
}

## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


resource "aws_secretsmanager_secret" "example" {
  for_each                = toset(var.aws-secret-string)
  name                    = "${var.tags["id"]}-${var.tags["environment"]}-${var.tags["project"]}-${each.value}"
  recovery_window_in_days = 0 # Disable retention policy
  tags                    = var.tags
}
