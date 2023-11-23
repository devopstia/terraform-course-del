```s
variable "tags" {
  type = map(any)
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "development"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

## 1 arg
bucket = format("%s-s3-bucket-tester", var.tags["environment"])
%s-s3-bucket-tester for 1 arg = development-s3-bucket-tester

bucket = format("tester-%s-s3-bucket", var.tags["environment"])
tester-%s-s3-bucket for 1 arg = tester-development-s3-bucket

## 2 arg
bucket = format("tester-%s-s3-bucket-%s", var.tags["environment"], data.aws_region.current.name)
tester-%s-s3-bucket-%s for 2 args = tester-development-s3-bucket-us-east-1

bucket = format("%s-s3-bucket-tester-%s", var.tags["environment"], data.aws_region.current.name)
%s-s3-bucket-tester-%s for 2 args = development-s3-bucket-tester-us-east-1

bucket = format("%s-%s-s3-bucket-tester", var.tags["environment"], data.aws_region.current.name)
%s-%s-s3-bucket-tester for 2 args = development-us-east-1-s3-bucket-tester

## 3 arg
bucket = format("%s-s3-bucket-tester-%s-%s", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
%s-s3-bucket-tester-%s-%s for 3 args = development-s3-bucket-tester-us-east-1-788210522308

bucket = format("%s-%s-%s-s3-bucket-tester", var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
%s-%s-%s-s3-bucket-tester for 3 args = development-us-east-1-788210522308-s3-bucket-tester

## 4 arg
bucket = format("%s-%s-%s-%s-s3-bucket-tester", var.tags["id"], var.tags["environment"], data.aws_region.current.name, data.aws_caller_identity.current.account_id)
%s-%s-%s-%s-s3-bucket-tester for 4 args = 2560-development-us-east-1-788210522308-s3-bucket-tester

bucket = format("%s-%s-s3-bucket-tester-%s-%s", var.tags["id"], data.aws_caller_identity.current.account_id, var.tags["environment"], data.aws_region.current.name)
%s-%s-%s-%s-s3-bucket-tester for 4 args = 2560-788210522308-s3-bucket-tester-development-us-east-1
```

