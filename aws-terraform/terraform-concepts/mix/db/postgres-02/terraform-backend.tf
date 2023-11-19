terraform {
  backend "s3" {
    bucket = "del-terraform-state"
    key    = "aws-terraform/db/postgres-bamboo/terraform.tfstate"
    region = "us-east-1"
    # dynamodb_table = "ektec-terraform-state-lock"
  }
}
