
# https://hands-on.cloud/managing-aws-iam-using-terraform/

# --------------------------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group

resource "aws_iam_group" "AWS-DevOpsAdmin" {
  name = "AWS-DevOpsAdmin"
  path = "/"
}


resource "aws_iam_group" "AWS-DevOpsEKSAdmin" {
  name = "AWS-DevOpsEKSAdmin"
  path = "/"
}


resource "aws_iam_group" "AWS-DevOpsReadonly" {
  name = "AWS-DevOpsReadonly"
  path = "/"
}


# --------------------------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user

resource "aws_iam_user" "aws-admin1" {
  name          = "admin1"
  force_destroy = true
  path          = "/"
  tags = {
    tag-key = "aws-admin1"
  }
}

resource "aws_iam_user" "aws-admin2" {
  name          = "admin2"
  force_destroy = true
  path          = "/"
  tags = {
    tag-key = "aws-admin2"
  }
}

resource "aws_iam_user" "aws-eks-admin1" {
  name          = "aws-eks-admin1"
  force_destroy = true
  path          = "/"
  tags = {
    tag-key = "aws-eks-admin1"
  }
}

resource "aws_iam_user" "aws-eks-admin2" {
  name          = "aws-eks-admin2"
  force_destroy = true
  path          = "/"
  tags = {
    tag-key = "aws-eks-admin2"
  }
}

resource "aws_iam_user" "aws-readonly" {
  name          = "aws-readonly"
  force_destroy = true
  path          = "/"
  tags = {
    tag-key = "aws-readonly"
  }
}

# --------------------------------------------------------------------------------
resource "aws_iam_group_policy_attachment" "aws-admin-full-access-policy-attachment" {
  group      = aws_iam_group.AWS-DevOpsAdmin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "aws-Readonly-access" {
  group      = aws_iam_group.AWS-DevOpsReadonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy
resource "aws_iam_policy" "aws-eks-admin-full-access-policy" {
  name        = "aws-eks-full-access-policy"
  description = "Allow all aws-eks-full-access-policy through AWS console"
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

resource "aws_iam_group_policy_attachment" "aws-eks-admin-full-access-policy-attachment" {
  group      = aws_iam_group.AWS-DevOpsEKSAdmin.name
  policy_arn = aws_iam_policy.aws-eks-admin-full-access-policy.arn
}

# # --------------------------------------------------------------------------------

#  Resource: AWS IAM Group Membership

resource "aws_iam_group_membership" "awsadmins" {
  name = "aws-admins-group-membership"
  users = [
    aws_iam_user.aws-admin1.name,
    aws_iam_user.aws-admin2.name
  ]
  group = aws_iam_group.AWS-DevOpsAdmin.name
}

resource "aws_iam_group_membership" "eksadmins" {
  name = "aws-eks-admins-group-membership"
  users = [
    aws_iam_user.aws-eks-admin1.name,
    aws_iam_user.aws-eks-admin2.name
  ]
  group = aws_iam_group.AWS-DevOpsEKSAdmin.name
}

resource "aws_iam_group_membership" "readonly" {
  name = "aws-eks-admins-group-membership"
  users = [
    aws_iam_user.aws-readonly.name
  ]
  group = aws_iam_group.AWS-DevOpsReadonly.name
}
