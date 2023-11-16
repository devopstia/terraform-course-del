data "aws_eks_cluster" "example" {
  name = var.control_plane_name
}

data "aws_eks_cluster_auth" "example" {
  name = var.control_plane_name
}
