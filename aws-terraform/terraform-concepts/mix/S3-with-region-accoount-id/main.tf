provider "aws" {
  region = "us-east-1"
}

variable "tags" {
  type = map(string)
  default = {
      owner         = "norm.nadeau@tcs.com" 
      project       = "mam" 
      environment   = "dev" 
      application   = "mam-dev" 
      t_dcl         = "2" 
      t_cost_centre = "9516.9130." 
      t_environment = "DEV"
      t_AppID       = "SVC02524232"
      terraform     =  "tree"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "repository" {
  bucket = format("%s-repository-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  //RESULT: dev-repository-us-east-1-788210522308

  tags   = merge(map("bucket-name", format("%s-repository-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)), map("csp_exception", "true"), var.tags)
  }
    //RESULT bucket-name: dev-repository-us-east-1-788210522308


resource "aws_s3_bucket" "collaborate" {
  bucket = format("%s-collaborate-config-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
  //RESULT: dev-collaborate-config-us-east-1-788210522308

  
  tags   = merge(map("Name", format("%s-collaborate-config-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)), map("csp_exception", "true"), var.tags)
  //RESULT bucket-name: dev-collaborate-config-us-east-1-788210522308

  versioning {
    enabled = true
  }
}