# main.tf

# Configure AWS provider
provider "aws" {
  region = "us-east-1" # Set your desired AWS region
}

# Create DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}

# Create S3 bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = "your-unique-s3-bucket-name"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Terraform   = "true"
    Environment = "production"
  }
}

# Configure S3 backend with DynamoDB table for state locking
terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.terraform_state.bucket
    key            = "terraform.tfstate"
    region         = "us-east-1" # Set your desired AWS region
    encrypt        = true
    dynamodb_table = aws_dynamodb_table.terraform_lock.name
  }
}
