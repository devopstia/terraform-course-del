resource "aws_iam_role" "nodes" {
  name = format("%s-%s-%s-blue-green-node-group-role", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])

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

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}


# This is for aws cluster autoscaller. 
# PS: aws cluster autoscaller will not works if we do not have this policy
resource "aws_iam_role_policy" "node-group-ClusterAutoscalerPolicy" {
  name = format("%s-%s-%s-blue-green-cluster-auto-scaler-policy", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
  role = aws_iam_role.nodes.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# This is for external dns. 
# PS: aws cexternal dns will not works if we do not have this policy
# https://repost.aws/knowledge-center/eks-set-up-externaldns
resource "aws_iam_role_policy" "external_dns_policy" {
  name = format("%s-%s-%s-blue-green-external-dns-policy", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
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



