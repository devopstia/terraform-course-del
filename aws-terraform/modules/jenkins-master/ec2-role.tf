# Define an IAM role with a trust policy
resource "aws_iam_role" "example_role" {
  # name = format("%s-%s-jenkins-role", var.common_tags["project"], var.common_tags["environment"])
  name = format("%s-%s-jenkins-role", var.common_tags["project"], var.common_tags["environment"])
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Define a custom AWS managed policy for EC2 full access
resource "aws_iam_policy" "ec2_full_access_policy" {
  name        = format("%s-%s-jenkins-policy", var.common_tags["project"], var.common_tags["environment"])
  description = "Custom policy for EC2 full access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "ec2:*",
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

# Attach the custom managed policy to an IAM role
resource "aws_iam_policy_attachment" "example_role_attachment" {
  name       = format("%s-%s-jenkins-policy-attachment", var.common_tags["project"], var.common_tags["environment"])
  roles      = [aws_iam_role.example_role.name]
  policy_arn = aws_iam_policy.ec2_full_access_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = format("%s-%s-jenkins-master-instance-profile", var.common_tags["project"], var.common_tags["environment"])
  role = aws_iam_role.example_role.name
}
