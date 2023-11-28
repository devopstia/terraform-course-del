terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "allowed_actions" {
  type = set(string)
  default = [
    "s3:GetObject",
    "s3:PutObject",
    "ec2:StartInstance",
    "ec2:StopInstance",
    "ec2:DescribeInstances",
    "sqs:SendMessage",
  ]
}

resource "aws_iam_policy" "example" {
  name_prefix = "example-policy-"

  description = "Example IAM policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = var.allowed_actions,
        Resource = "*",
      },
    ],
  })
}
