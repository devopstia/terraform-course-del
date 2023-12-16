provider "aws" {
  region = "us-east-1"
}

# Define a list of AWS actions
variable "aws_actions" {
  type    = list(string)
  default = ["s3:GetObject", "s3:ListBucket", "ec2:DescribeInstances"]
}

# Split the list of actions into a comma-separated string
locals {
  actions_string = join(",", var.aws_actions)
}

# Create an AWS IAM policy document using the split actions
data "aws_iam_policy_document" "example_policy" {
  source_json = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = split(",", local.actions_string),
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

output "iam_policy_json" {
  value = data.aws_iam_policy_document.example_policy.json
}
