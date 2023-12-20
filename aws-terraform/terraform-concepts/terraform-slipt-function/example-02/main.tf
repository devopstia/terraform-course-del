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

variable "space_delimited_string" {
  type    = string
  default = "Alice Bob Charlie David Eve"
}

locals {
  names = split(" ", var.space_delimited_string)
}

output "names_list" {
  value = local.names
}


