# resource "aws_eks_node_group" "blue" {
#   cluster_name    = aws_eks_cluster.eks.name
#   node_group_name = "alpha-blue-node-group"
#   node_role_arn   = aws_iam_role.nodes.arn

#   version = "1.22"

#   subnet_ids = [
#     # aws_subnet.private_1.id,
#     # aws_subnet.private_2.id
#     aws_subnet.public_1.id,
#     aws_subnet.public_2.id
#   ]

#   scaling_config {
#     desired_size = 1
#     min_size     = 1
#     max_size     = 6
#   }

#   ami_type             = "AL2_x86_64"
#   capacity_type        = "ON_DEMAND"
#   disk_size            = 20
#   force_update_version = false
#   instance_types       = ["t2.micro"]

#   labels = {
#     deployment_nodegroup = "blue_green"
#   }

#   remote_access {
#     ec2_ssh_key = "jenkins-key"
#   }

#   tags = {
#     Name                                 = "Apha Blue Node Group"
#     "k8s.io/cluster-autoscaler/${var.control_plane_name}"      = "shared"
#     "k8s.io/cluster-autoscaler/enabled " = "true"
#   }
# }















