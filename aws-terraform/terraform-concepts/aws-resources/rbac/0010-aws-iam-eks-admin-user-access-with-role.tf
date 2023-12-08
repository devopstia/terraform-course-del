
resource "aws_iam_role" "AWS-EKS-Admin-Role" {
  name = "AWS-EKS-Admin-Role"

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
    tag-key = "AWS-EKS-Admin-Role"
  }
}
# https://docs.aws.amazon.com/eks/latest/userguide/security_iam_id-based-policy-examples.html
# https://antonputra.com/kubernetes/add-iam-user-and-iam-role-to-eks/
resource "aws_iam_policy" "AWS-EKS-Admin-polcy" {
  name = "AWS-EKS-Admin-polcy"

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:*"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:PassRole",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:PassedToService" : "eks.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AWS-EKS-Admin-Role-policy-attachment" {
  role       = aws_iam_role.AWS-EKS-Admin-Role.name
  policy_arn = aws_iam_policy.AWS-EKS-Admin-polcy.arn
}


# Resource: AWS IAM Group 
resource "aws_iam_group" "ADFS-EKS-Admins" {
  name = "ADFS-EKS-Admins"
  path = "/"
}


# Resource: AWS IAM Group Policy
resource "aws_iam_group_policy" "ADFS-EKS-Admins-policy" {
  name  = "ADFS-EKS-Admins-Policy"
  group = aws_iam_group.ADFS-EKS-Admins.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid      = ""
        Resource = "${aws_iam_role.AWS-EKS-Admin-Role.arn}"
      },
    ]
  })
}

resource "aws_iam_user" "aws-eks-admin-user-1" {
  name          = "aws-eks-admin-user-1"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-eks-admin-user-1"
  }
}

resource "aws_iam_user" "aws-eks-admin-user-2" {
  name          = "aws-eks-admin-user-2"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-eks-admin-user-2"
  }
}

resource "aws_iam_user" "aws-eks-admin-user-3" {
  name          = "aws-eks-admin-user-3"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-eks-admin-user-3"
  }
}


# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "ADFS-EKS-Admins-membership" {
  name = "ADFS-EKS-Admins-Membership"
  users = [
    aws_iam_user.aws-eks-admin-user-1.name,
    aws_iam_user.aws-eks-admin-user-2.name,
    aws_iam_user.aws-eks-admin-user-3.name,
  ]
  group = aws_iam_group.ADFS-EKS-Admins.name
}


resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.AWS-EKS-Admin-Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "ReadOnlyAccess" {
  role       = aws_iam_role.AWS-EKS-Admin-Role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "CloudWatchLogsFullAccess" {
  role       = aws_iam_role.AWS-EKS-Admin-Role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  role       = aws_iam_role.AWS-EKS-Admin-Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.AWS-EKS-Admin-Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  role       = aws_iam_role.AWS-EKS-Admin-Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}


