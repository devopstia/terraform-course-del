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

variable "bucket_name" {
  type    = string
  default = "s3-bucket-tester"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "example_bucket1" {
  bucket = "${var.tags["environment"]}-${var.bucket_name}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
  tags   = var.tags
}

resource "aws_s3_bucket" "example_bucket2" {
  bucket = "${var.tags["environment"]}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
  tags   = var.tags
}





