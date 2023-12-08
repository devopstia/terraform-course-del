
resource "aws_iam_role" "AWS-Admin-Role" {
  name = "AWS-Admin-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          # https://marcincuber.medium.com/amazon-eks-rbac-and-iam-access-f124f1164de7
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      },
    ]
  })
  tags = {
    tag-key = "AWS-Admin-Role"
  }
}


# https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AdministratorAccess
resource "aws_iam_role_policy_attachment" "AWS-Admin-Role-policy-attachment" {
  role       = aws_iam_role.AWS-Admin-Role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Resource: AWS IAM Group 
resource "aws_iam_group" "ADFS-AWS-Admins" {
  name = "ADFS-AWS-Admins"
  path = "/"
}

# Resource: AWS IAM Group Policy
resource "aws_iam_group_policy" "aws-admins_iam_group_assumerole_policy" {
  name  = "ADFS-AWS-Admins-Policy"
  group = aws_iam_group.ADFS-AWS-Admins.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid      = ""
        Resource = "${aws_iam_role.AWS-Admin-Role.arn}"
      },
    ]
  })
}

# Resource: AWS IAM User - Basic User 
resource "aws_iam_user" "aws-admin-user-1" {
  name          = "aws-admin-user-1"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-admin-user-1"
  }
}

resource "aws_iam_user" "aws-admin-user-2" {
  name          = "aws-admin-user-2"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-admin-user-2"
  }
}

resource "aws_iam_user" "aws-admin-user-3" {
  name          = "aws-admin-user-3"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-admin-user-3"
  }
}


# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "ADFS-AWS-Admins-membership" {
  name = "ADFS-AWS-Admins-Membership"
  users = [
    aws_iam_user.aws-admin-user-1.name,
    aws_iam_user.aws-admin-user-2.name,
    aws_iam_user.aws-admin-user-3.name,
  ]
  group = aws_iam_group.ADFS-AWS-Admins.name
}

