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

variable "s3_bucket_config" {
  description = "Configuration for an S3 bucket"
  type        = tuple([number, string, bool])
  default     = [1, "example-bucket-xx1254ded", true]
}

resource "aws_s3_bucket" "example" {
  count = var.s3_bucket_config[0]

  bucket = "${var.s3_bucket_config[1]}-${count.index + 1}"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = var.s3_bucket_config[3]
  }
}


