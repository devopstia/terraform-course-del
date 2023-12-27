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

variable "user_names" {
  description = "IAM usernames"
  type        = list(any)
  default     = ["annie", "amy", "alain", "viviane"]
}

resource "aws_iam_user" "iam_users" {
  for_each = toset(var.user_names)

  name = each.key

  tags = {
    "Environment" = "Production"
    "Owner"       = "Terraform"
  }
}

# Additional attributes for each IAM user
output "iam_user_arns1" {
  value = { for user_name, user in aws_iam_user.iam_users : user_name => user.arn }
}

# Additional attributes for each IAM user
output "iam_user_arns2" {
  value = [for user in aws_iam_user.iam_users : user.arn]
}
