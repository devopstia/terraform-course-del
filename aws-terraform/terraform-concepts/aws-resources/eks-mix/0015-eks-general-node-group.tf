# # Resource: aws_eks_node_group
# # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

# resource "aws_eks_node_group" "nodes_general" {
#   # Name of the EKS Cluster.
#   cluster_name = aws_eks_cluster.eks.name

#   # Name of the EKS Node Group.
#   node_group_name = "alpha-general-node-group"

#   # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
#   node_role_arn = aws_iam_role.nodes.arn

#   # Kubernetes version
#   version = "1.22"

#   # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
#   # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
#   # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
#   subnet_ids = [
#     # aws_subnet.private_1.id,
#     # aws_subnet.private_2.id
#     aws_subnet.public_1.id,
#     aws_subnet.public_2.id
#   ]

#   # Configuration block with scaling settings
#   scaling_config {
#     # Desired number of worker nodes.
#     desired_size = 1

#     # Minimum number of worker nodes.
#     min_size = 1

#     # Maximum number of worker nodes.
#     max_size = 6
#   }

#   # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
#   # Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
#   ami_type = "AL2_x86_64"

#   # Type of capacity associated with the EKS Node Group. 
#   # Valid values: ON_DEMAND, SPOT
#   capacity_type = "ON_DEMAND"

#   # Disk size in GiB for worker nodes
#   disk_size = 20

#   # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
#   force_update_version = false

#   # List of instance types associated with the EKS Node Group
#   instance_types = ["t2.micro"]

#   labels = {
#     deployment_nodegroup = "general"
#   }

#   remote_access {
#     ec2_ssh_key = "jenkins-key"
#   }

#   #   # Only pod that can tolerate the taint will be deploy on this nodes or node group
#   #   taint {
#   #     key    = "team"
#   #     value  = "devops"
#   #     effect = "NO_SCHEDULE"
#   #   }

#   # This tag is very usefull for cluster-autoscaler
#   # PS: cluster-autoscaler will not work if we do not have this tag
#   tags = {
#     Name                                                  = "EKS General Node Group"
#     "k8s.io/cluster-autoscaler/${var.control_plane_name}" = "shared"
#     "k8s.io/cluster-autoscaler/enabled "                  = "true"
#   }
# }
