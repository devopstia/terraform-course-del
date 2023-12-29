terraform {
  backend "s3" {
    bucket = "2560-dev-del-backend"
    key    = "testing/ec2-workspace/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "2560-development-del-tf-state-lock"
  }
}