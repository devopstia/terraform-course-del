provider "aws" {
  region = var.region

  version = "3.22.0"
}

terraform {
  required_version = ">= 0.12"

}
