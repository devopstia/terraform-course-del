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

variable "fruits" {
  type    = list(any)
  default = ["apple", "banana", "orange", "grape"]
}

output "contains_apple" {
  value = contains(var.fruits, "apple")
}

output "contains_banana" {
  value = contains(var.fruits, "banana")
}

output "contains_orange" {
  value = contains(var.fruits, "orange")
}

output "contains_grape" {
  value = contains(var.fruits, "grape")
}

output "contains_tia" {
  value = contains(var.fruits, "tia")
}
