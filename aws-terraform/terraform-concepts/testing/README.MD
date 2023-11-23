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

variable "bucket_name" {
  type    = string
  default = "s3-bucket-tester"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

## Example 01
bucket = "${var.tags["environment"]}-s3-bucket-tester"
bucket name = development-s3-bucket-tester

bucket = format("tester-%s-s3-bucket", var.tags["environment"])
bucket name = tester-s3-bucket-tester-development

## Example 02
bucket = "tester-${var.tags["environment"]}-s3-bucket-${data.aws_region.current.name}"
bucket name = tester-development-s3-bucket-us-east-1

bucket = bucket = "${var.tags["environment"]}-s3-bucket-tester-${data.aws_region.current.name}"
bucket name = development-s3-bucket-tester-us-east-1

bucket = "${var.tags["environment"]}-${data.aws_region.current.name}-s3-bucket-tester"
bucket name = development-us-east-1-s3-bucket-tester

## Example 03
bucket = "${var.tags["environment"]}-${var.bucket_name}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
bucket name = development-s3-bucket-tester-us-east-1-788210522308

bucket = "${var.tags["environment"]}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
bucket name = development-us-east-1-788210522308-s3-bucket-tester

## Example 04
bucket = "${var.tags["id"]}-${var.tags["environment"]}-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
bucket name = 2560-development-us-east-1-788210522308-s3-bucket-tester

bucket = "${var.tags["id"]}-${data.aws_caller_identity.current.account_id}-${var.bucket_name}-${var.tags["environment"]}-${data.aws_region.current.name}"
bucket name = 2560-788210522308-s3-bucket-tester-development-us-east-1
```

