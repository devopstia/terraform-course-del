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
  region = "us-east-1" # Change to your desired AWS region
}

data "aws_caller_identity" "my_account" {}


resource "aws_s3_bucket" "bucket1" {
  bucket = "${data.aws_caller_identity.my_account.id}-bucket1"
}

resource "aws_s3_bucket" "bucket2" {
  bucket = data.aws_caller_identity.my_account.id
  depends_on = [
    aws_s3_bucket.bucket1
  ]
}

