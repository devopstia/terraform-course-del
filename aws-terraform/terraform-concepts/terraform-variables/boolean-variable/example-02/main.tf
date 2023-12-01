terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "bucket_suffix_length" {
  description = "Length of the random bucket suffix"
  type        = number
  default     = 8 # Replace with your desired length
}

variable "bucket_suffix_special" {
  description = "Include special characters in the random bucket suffix"
  type        = bool
  default     = false # Set to true if you want special characters
}

variable "bucket_suffix_upper" {
  description = "Include uppercase letters in the random bucket suffix"
  type        = bool
  default     = false # Set to false if you don't want uppercase letters
}

variable "bucket_suffix_number" {
  description = "Include numbers in the random bucket suffix"
  type        = bool
  default     = true # Set to false if you don't want numbers
}

# Random string resource
resource "random_string" "bucket_suffix" {
  length  = var.bucket_suffix_length
  special = var.bucket_suffix_special
  upper   = var.bucket_suffix_upper
  numeric = var.bucket_suffix_number
}

# S3 bucket resource
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-unique-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name      = "my-unique-bucket-${random_string.bucket_suffix.result}"
    Create_By = "Terraform"
  }
}
