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

variable "record" {
  type    = string
  default = "artifactory.devopseasylearning.net:5432"
}

output "split" {
  value = split(":", var.record)
}

output "record_split" {
  value = (split(":", var.record)[0])
}

output "record_split1" {
  value = (split(":", var.record)[1])
}
