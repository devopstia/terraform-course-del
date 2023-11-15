terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "us-east-1"
}

# Define a number variable for the count of S3 buckets
variable "bucket_count" {
  description = "Number of AWS S3 buckets to create"
  type        = number
  default     = 3 # You can change the default value as needed
}

# Create AWS S3 buckets based on the variable count
resource "aws_s3_bucket" "example" {
  count = var.bucket_count # Use the variable to determine the number of buckets

  bucket = "example-bucket-${count.index + 1}" # Create unique bucket names
}

