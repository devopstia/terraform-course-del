# Resource: AWS IAM User - Admin User (Has Full AWS Access)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user

resource "aws_iam_user" "awsadmin" {
  name = "awsadmin"
  path = "/"

  # This is to force and delete the IAM user
  force_destroy = true
  tags = {
    Access_type = "AWS Admin Full Access"
  }
}

# Resource: AWS IAM Group 
resource "aws_iam_group" "AWS-Admins-Group" {
  name = "AWS-Admins-Group"
  path = "/"
}

# Resource: AWS IAM Group Policy
resource "aws_iam_group_policy" "AWS-Admins-Group_iam_group_assumerole_policy" {
  name  = "AWS-Admins-Group-Polcy"
  group = aws_iam_group.AWS-Admins-Group.name

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
}

# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "AWS-Admins-Group-membership" {
  name = "AWS-Admins-Group-Membership"
  users = [
    aws_iam_user.awsadmin.name,
  ]
  group = aws_iam_group.AWS-Admins-Group.name
}
