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

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name"
  # Prevent accidental deletion of the S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  depends_on = [aws_s3_bucket.my_bucket]
  bucket     = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}