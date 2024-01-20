
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

variable "original_string" {
  type    = string
  default = "one|two|three"
}

locals {
  split_list    = split("|", var.original_string)
  joined_string = join("-", local.split_list)
}

output "split" {
  value = local.split_list
}

output "joined_string" {
  value = local.joined_string
}

