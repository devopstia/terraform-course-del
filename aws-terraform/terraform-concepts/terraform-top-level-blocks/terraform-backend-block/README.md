## Backend
```s
terraform {
  backend "s3" {
    bucket         = "s3 bucket name where to store the terraform.tfstate file"
    key            = "path to the terraform.tfstate file in s3 bucket"
    region         = "region-where-you want to deploy"
    dynamodb_table = "the dynamodb table name to lock the state file"
  }
}

terraform {
  backend "s3" {
    bucket         = "del-terraform-state"
    key            = "aws-terraform/vpc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "del-terraform-state-lock"
  }
}

terraform {
  backend "s3" {
    bucket         = "2560-development-del-tf-state"
    key            = "aws-terraform/eks-controle-plane/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "2560-development-del-tf-state-lock"
  }
}
```