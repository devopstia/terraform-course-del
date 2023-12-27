provider "aws" {
  region = "us-east-1"
}

variable "bucket_names" {
  type    = list(string)
  default = ["bucket1", "bucket2", "bucket3"]
}

resource "aws_s3_bucket" "example" {
  for_each = { for idx, name in var.bucket_names : idx => name }

  bucket = each.key
  tags = {
    Name        = each.value
    Environment = "dev"
  }
}
