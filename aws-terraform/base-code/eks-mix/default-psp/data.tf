data "aws_eks_cluster" "example" {
  name = "2560-adl-dev"
}

data "aws_eks_cluster_auth" "example" {
  name = "2560-adl-dev"
}
