data "aws_eks_cluster" "example" {
  name = "demo-cluster"
}

data "aws_eks_cluster_auth" "example" {
  name = "demo-cluster"
}
