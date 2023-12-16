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

variable "example_list" {
  type    = list(string)
  default = ["one", "two", "three"]
}

output "first_element" {
  value = var.example_list[0]
}

output "second_element" {
  value = var.example_list[1]
}

output "third" {
  value = var.example_list[2]
}

output "all_element" {
  value = var.example_list[*]
}