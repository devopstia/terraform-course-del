resource "aws_eks_fargate_profile" "kube-system" {
  cluster_name           = format("%s-%s-%s", var.tags["id"], var.tags["environment"], var.tags["project"])
  fargate_profile_name   = "kube-system"
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

  subnet_ids = values(var.public_subnets)

  selector {
    namespace = "kube-system"
  }
}
