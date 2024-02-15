# Resource: AWS IAM User - AWS aws User (Has aws AWS Access)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user

resource "aws_iam_user" "awsreadonly" {
  name = "awsreadonly"
  path = "/"

  # This is to force and delete the IAM user
  force_destroy = true
  tags = {
    Access_type = "AWS EKS Admin Full Access"
  }
}

# allow readonly access to aws
resource "aws_iam_user_policy_attachment" "aws-readonly-access-policy-to-aws" {
  user       = aws_iam_user.awsreadonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
