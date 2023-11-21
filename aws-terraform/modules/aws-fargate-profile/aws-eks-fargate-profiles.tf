resource "aws_eks_fargate_profile" "app" {
  for_each               = toset(var.fargate-profiles)
  cluster_name           = var.cluster_name
  fargate_profile_name   = each.key
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

  subnet_ids = values(var.private_subnets)
  selector {
    namespace = each.key
  }
}
