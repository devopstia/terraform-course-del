provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "california"
  region = "us-west-1"
}

provider "aws" {
  alias = "ohio"
  region = "us-east-2"
}


resource "aws_s3_bucket" "california_bucket" {
  provider = aws.california
  bucket = "tia1254"
}

resource "aws_s3_bucket" "ohio_bucket" {
  provider = aws.ohio
  bucket = "tia1254587"
}

resource "aws_s3_bucket" "default_bucket" {
  bucket = "tia125458710"
}