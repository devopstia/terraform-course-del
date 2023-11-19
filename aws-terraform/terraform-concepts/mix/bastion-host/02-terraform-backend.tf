terraform {
  backend "s3" {
    bucket         = "2560-dev-alpha-terraform-state"
    key            = "bastion-host/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "2560-dev-alpha-terraform-state-lock"
  }
}
