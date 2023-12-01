# resource "aws_s3_bucket" "backend" {
#   bucket = format("%s-%s-%s-tf-state", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
#   # versioning {
#   #   enabled = true
#   # }
#   tags = var.common_tags
# }

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
  region = var.aws_region
}

resource "aws_s3_bucket" "backend" {
  bucket = format("%s-%s-%s-tf-state", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  tags   = var.common_tags
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  depends_on = [aws_s3_bucket.backend]
  bucket     = aws_s3_bucket.backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tf-state-lock" {
  name           = format("%s-%s-%s-tf-state-lock", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = var.common_tags
}



