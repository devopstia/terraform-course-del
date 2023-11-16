resource "aws_iam_role" "eks_cluster" {
  name               = format("%s-%s-%s-eks-role", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
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

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "eks" {
  name     = format("%s-%s-%s", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.eks_version

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    subnet_ids = [
      data.aws_subnet.public_1.id,
      data.aws_subnet.public_2.id
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}

