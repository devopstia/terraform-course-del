provider "aws" {
  region = "us-east-2" # Specify your desired AWS region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name" # Specify a globally unique bucket name
  tags = {
    Name        = "my-unique-bucket-3jf7lkd0"
    Environment = "Production"
  }
}
