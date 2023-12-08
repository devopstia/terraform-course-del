resource "aws_s3_bucket" "example_bucket" {
  bucket = "${var.bucket_name}-${random_string.bucket_suffix.result}"

  tags = {
    Name      = "${var.bucket_name}-${random_string.bucket_suffix.result}"
    Create_By = "Terraform"
  }
}
