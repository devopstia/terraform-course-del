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


variable "create_bucket" {
  description = "Set to true to create the S3 bucket, false to skip creation."
  type        = bool
  default     = false # Default to skip bucket creation.
}

variable "region" {
  description = "The AWS region for the S3 bucket."
  type        = string
  default     = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  count = var.create_bucket && (var.region == "us-east-1" || var.region == "us-west-1") ? 1 : 0

  bucket = "my-example-bucket"
  region = var.region
}
