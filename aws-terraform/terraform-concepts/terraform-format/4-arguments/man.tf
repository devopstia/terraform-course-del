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

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "development"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "example_bucket1" {
  bucket = format("%s-%s-%s-%s-s3-bucket-tester", var.tags["id"], var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  tags   = var.tags
}

resource "aws_s3_bucket" "example_bucket2" {
  bucket = format("%s-%s-s3-bucket-tester-%s-%s", var.tags["id"], data.aws_caller_identity.current.account_id, var.tags["environment"], data.aws_region.current.name)
  tags   = var.tags
}







