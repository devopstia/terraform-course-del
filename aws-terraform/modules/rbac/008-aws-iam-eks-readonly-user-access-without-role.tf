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

# Resource: AWS IAM Group 
resource "aws_iam_group" "AWS-ReadOnly-Group" {
  name = "AWS-ReadOnly-Group"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "aws-readonly-access-policy-attachment" {
  group      = aws_iam_group.AWS-ReadOnly-Group.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# Resource: AWS IAM Group Policy
resource "aws_iam_group_policy" "EKS-Cluster-Action" {
  name  = "EKS-Cluster-Action-Polcy"
  group = aws_iam_group.AWS-ReadOnly-Group.name

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:AccessKubernetesApi",
          "eks:ListUpdates",
        ],
        "Resource" : [
          "arn:aws:eks:us-east-1:788210522308:cluster/'${data.aws_eks_cluster.example.name}'",
        ]
      }
    ]
  })
}

# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "AWS-ReadOnly-Group-membership" {
  name = "AWS-ReadOnly-Group-Membership"
  users = [
    aws_iam_user.awsreadonly.name,
  ]
  group = aws_iam_group.AWS-ReadOnly-Group.name
}
