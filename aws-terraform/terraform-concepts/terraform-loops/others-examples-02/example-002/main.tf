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

variable "user_names_1" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["annie", "amy", "alain", "viviane"]
}

resource "aws_iam_user" "iam_users" {
  for_each = toset(var.user_names_1)

  name = each.value

  tags = {
    "Environment" = "Production"
    "Owner"       = "Terraform"
  }
}

# # Additional attributes for each IAM user
# output "iam_users_info" {
#   value = [
#     for user_name, user in aws_iam_user.iam_users : {
#       username = user.name
#       arn      = user.arn
#       id       = user.id
#     }
#   ]
# }

# # IAM Usernames
# output "iam_usernames" {
#   value = [for user_name, user in aws_iam_user.iam_users : user.name]
# }

# # IAM ARNs
# output "iam_arns" {
#   value = [for user_name, user in aws_iam_user.iam_users : user.arn]
# }

# # IAM IDs
# output "iam_ids" {
#   value = [for user_name, user in aws_iam_user.iam_users : user.unique_id]
# }



# IAM Usernames
output "iam_usernames" {
  value = {
    for user_name, user in aws_iam_user.iam_users : user_name => user.name
  }
}

# IAM ARNs
output "iam_arns" {
  value = {
    for user_name, user in aws_iam_user.iam_users : user_name => user.arn
  }
}

# IAM IDs
output "iam_ids" {
  value = {
    for user_name, user in aws_iam_user.iam_users : user_name => user.unique_id
  }
}