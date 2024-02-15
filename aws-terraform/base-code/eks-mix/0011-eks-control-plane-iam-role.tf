# Resource: aws_iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

resource "aws_iam_role" "demo" {
  # the name of the role
  name = "eks-cluster-role"

  # we must create a IAM role before we create the EKS cluster
  # The role that Amazon EKS will use to create AWS resources for Kubernetes clusters
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# The ARN of the policy you want to apply
# These are default policies created in AWS by default for EKS. This are AWS manage policies
# This policy provides Kubernetes the permissions it requires to manage resources on your behalf

# https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSClusterPolicy
resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # The role the policy should be applied to
  role = aws_iam_role.demo.name
}

# Policy used by VPC Resource Controller to manage ENI and IPs for worker nodes. 
# we need this because EKS will create ENI for worker nodes when we create a cluster
resource "aws_iam_role_policy_attachment" "demo-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"

  # The role the policy should be applied to
  role = aws_iam_role.demo.name
}

# this is usual to capture the control components logs
resource "aws_iam_role_policy" "eks-cloud-watch-control-plane" {
  name = "eks-cloudwatch-policy"
  role = aws_iam_role.demo.name

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        }
    ]
}
POLICY
}
















