
data "aws_eks_cluster" "example" {
  name = format("%s-%s-%s", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
}

data "aws_eks_cluster_auth" "example" {
  name = format("%s-%s-%s", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}
