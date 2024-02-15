# resource "aws_eks_fargate_profile" "kube-system" {
#   cluster_name           = var.control_plane_name
#   fargate_profile_name   = "kube-system"
#   pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

#   # These subnets must have the following resource tag: 
#   # kubernetes.io/cluster/<CLUSTER_NAME>.
#   subnet_ids = [
#     aws_subnet.private_1.id,
#     aws_subnet.private_1.id
#   ]

#   selector {
#     namespace = "kube-system"
#   }
# }
