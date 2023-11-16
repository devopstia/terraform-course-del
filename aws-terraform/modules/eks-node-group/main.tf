resource "aws_eks_node_group" "nodes-group" {
  cluster_name    = format("%s-%s-%s", var.tags["id"], var.tags["environment"], var.tags["project"])
  node_group_name = format("%s-%s-%s-node-group", var.tags["id"], var.tags["environment"], var.tags["project"])
  node_role_arn   = aws_iam_role.nodes.arn

  version = var.eks_version

  subnet_ids = values(var.private_subnets)

  capacity_type = var.capacity_type
  ami_type      = var.ami_type

  instance_types = [var.instance_types]
  disk_size      = var.disk_size

  remote_access {
    ec2_ssh_key = var.ec2_ssh_key
  }

  scaling_config {
    desired_size = var.node_min
    min_size     = var.desired_node
    max_size     = var.node_max
  }

  labels = {
    deployment_nodegroup = var.deployment_nodegroup
  }

  tags = merge(var.tags, {
    Name                                                  = format("%s-%s-%s-node-group", var.tags["id"], var.tags["environment"], var.tags["project"])
    "k8s.io/cluster-autoscaler/${var.control_plane_name}" = "${var.shared_owned}"
    "k8s.io/cluster-autoscaler/enabled"                   = "${var.enable_cluster_autoscaler}"
    },
  )
}
