
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

variable "comma_separated_list" {
  type    = string
  default = "apple,banana,cherry"
}

locals {
  fruits = split(",", var.comma_separated_list)
}

output "fruits_list" {
  value = local.fruits
}
