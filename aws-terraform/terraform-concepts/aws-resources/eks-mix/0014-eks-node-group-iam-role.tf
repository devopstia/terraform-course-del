# Resource: aws_iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

resource "aws_iam_role" "nodes" {
  # Create IAM role for EKS Node Group
  name = "eks-node-group-role-iam"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment


# This policy allows Amazon EKS worker nodes to connect to Amazon EKS Clusters (This grant access to EC2)
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  # The role the policy should be applied to
  role = aws_iam_role.nodes.name
}

# To configure the container network
# This policy provides the Amazon VPC CNI Plugin (amazon-vpc-cni-k8s) the permissions it requires to modify the IP address configuration on your EKS worker nodes. This permission set allows the CNI to list, describe, and modify Elastic Network Interfaces on your behalf. More information on the AWS VPC CNI Plugin is available here: https://github.com/aws/amazon-vpc-cni-k8s
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  # The role the policy should be applied to
  role = aws_iam_role.nodes.name
}

# This grant access to ERC repository
# Provides read-only access to Amazon EC2 Container Registry repositories.
resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  # The role the policy should be applied to
  role = aws_iam_role.nodes.name
}

# https://dev.to/stack-labs/securing-the-connectivity-between-amazon-eks-and-amazon-rds-part-3-405a
# https://docs.aws.amazon.com/eks/latest/userguide/autoscaling.html

# # This is for aws cluster autoscaller. 
# # PS: aws cluster autoscaller will not works if we do not have this policy
# resource "aws_iam_role_policy" "node-group-ClusterAutoscalerPolicy" {
#   name = "eks-cluster-auto-scaler-policy"
#   role = aws_iam_role.nodes.name

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "autoscaling:DescribeAutoScalingGroups",
#           "autoscaling:DescribeAutoScalingInstances",
#           "autoscaling:DescribeLaunchConfigurations",
#           "autoscaling:DescribeTags",
#           "autoscaling:SetDesiredCapacity",
#           "autoscaling:TerminateInstanceInAutoScalingGroup",
#           "ec2:DescribeLaunchTemplateVersions"
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# # This is for aws cluster autoscaller. 
# # PS: aws cluster autoscaller will not works if we do not have this policy
# resource "aws_iam_role_policy" "node_group_ebs_ebs_csi_driver" {
#   name = "amanzon-ebs-csi-driver-policy"
#   role = aws_iam_role.nodes.name

#   policy = jsonencode({
#     Version = "2012-10-17"
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "ec2:AttachVolume",
#           "ec2:CreateSnapshot",
#           "ec2:CreateTags",
#           "ec2:CreateVolume",
#           "ec2:DeleteSnapshot",
#           "ec2:DeleteTags",
#           "ec2:DeleteVolume",
#           "ec2:DescribeInstances",
#           "ec2:DescribeSnapshots",
#           "ec2:DescribeTags",
#           "ec2:DescribeVolumes",
#           "ec2:DetachVolume"
#         ],
#         "Resource" : "*"
#       }
#     ]
#   })
# }


# This is for aws cluster autoscaller. 
# PS: aws cluster autoscaller will not works if we do not have this policy
resource "aws_iam_role_policy" "external_dns_policy" {
  name = "external-dns-policy"
  role = aws_iam_role.nodes.name

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}



