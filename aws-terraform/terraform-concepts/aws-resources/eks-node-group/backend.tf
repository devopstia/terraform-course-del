terraform {
  backend "s3" {
    bucket         = "2560-dev-s4-state"
    dynamodb_table = "2560-dev-s4-state-lock"
    key            = "eks-node-group/terraform.tfstate"
    region         = "us-east-1"
  }
}
