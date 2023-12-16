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

variable "date_string" {
  type    = string
  default = "2023-12-25"
}

locals {
  date_parts  = split("-", var.date_string)
  joined_date = join("/", local.date_parts)
}

output "joined_date" {
  value = local.joined_date
}
