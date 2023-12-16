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

variable "servers" {
  type = map(any)
  default = {
    web      = "192.168.1.10"
    database = "192.168.1.20"
    app      = "192.168.1.30"
  }
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

output "server_ips" {
  value = var.servers[*]
}

output "tags_values" {
  value = var.tags[*]
}