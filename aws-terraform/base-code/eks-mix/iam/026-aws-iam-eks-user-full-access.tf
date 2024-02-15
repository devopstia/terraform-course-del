# Resource: AWS IAM User - EKS Admin User (Has EKS Full AWS Access)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user

resource "aws_iam_user" "awseksadmin" {
  name = "awseksadmin"
  path = "/"

  # This is to force and delete the IAM user
  force_destroy = true
  tags = {
    Access_type = "AWS EKS Admin Full Access"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy
resource "aws_iam_user_policy" "eks-full-access-policy" {
  name = "eks-full-access-policy"
  user = aws_iam_user.awseksadmin.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:ListRoles",
          "eks:*",
          "ssm:GetParameter"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
