# resource "aws_eks_fargate_profile" "fp-dev" {
#   cluster_name           = var.control_plane_name
#   fargate_profile_name   = "fp-dev"
#   pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

#   # These subnets must have the following resource tag: 
#   # kubernetes.io/cluster/<CLUSTER_NAME>.
#   subnet_ids = [
#     aws_subnet.private_1.id,
#     aws_subnet.private_1.id
#   ]
#   selector {
#     namespace = "fp-dev"
#   }
# }


# resource "aws_eks_fargate_profile" "qa" {
#   cluster_name           = var.control_plane_name
#   fargate_profile_name   = "qa"
#   pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

#   # These subnets must have the following resource tag: 
#   # kubernetes.io/cluster/<CLUSTER_NAME>.
#   subnet_ids = [
#     aws_subnet.private_1.id,
#     aws_subnet.private_1.id
#   ]
#   selector {
#     namespace = "qa"
#   }
# }

# resource "aws_eks_fargate_profile" "stg" {
#   cluster_name           = var.control_plane_name
#   fargate_profile_name   = "stg"
#   pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

#   # These subnets must have the following resource tag: 
#   # kubernetes.io/cluster/<CLUSTER_NAME>.
#   subnet_ids = [
#     aws_subnet.private_1.id,
#     aws_subnet.private_1.id
#   ]
#   selector {
#     namespace = "stg"
#   }
# }
