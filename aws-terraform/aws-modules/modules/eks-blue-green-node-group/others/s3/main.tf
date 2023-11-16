locals {
  control_plane_name = format("%s-%s-%s", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
}

resource "aws_eks_node_group" "green-nodes" {
  cluster_name    = format("%s-%s-%s", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
  node_group_name = format("%s-%s-%s-green-node-group", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
  node_role_arn   = aws_iam_role.nodes.arn

  version = var.eks_version

  subnet_ids = [
      data.aws_subnet.private_subnet1.id,
      data.aws_subnet.private_subnet2.id
    ]

  capacity_type = var.capacity_type
  ami_type      = var.ami_type

  instance_types = [var.instance_types]
  disk_size      = var.disk_size

  remote_access {
    ec2_ssh_key = var.ec2_ssh_key
  }

  scaling_config {
    desired_size = var.green_node_color == "green" && var.green ? var.desired_node : 0
    min_size     = var.green_node_color == "green" && var.green ? var.node_min : 0
    max_size     = var.green_node_color == "green" && var.green ? var.node_max : var.node_max
  }

  labels = {
    deployment_nodegroup = var.deployment_nodegroup
  }

  tags = merge(var.common_tags, {
    Name                                                    = format("%s-%s-%s-green-node-group", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    "k8s.io/cluster-autoscaler/${local.control_plane_name}" = "${var.shared_owned}"
    "k8s.io/cluster-autoscaler/enabled"                     = "${var.enable_cluster_autoscaler}"
    },
  )
}

resource "aws_eks_node_group" "blue-nodes" {
  cluster_name    = format("%s-%s-%s", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
  node_group_name = format("%s-%s-%s-blue-node-group", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
      data.aws_subnet.private_subnet1.id,
      data.aws_subnet.private_subnet2.id
    ]

  version = var.eks_version

  capacity_type = var.capacity_type
  ami_type      = var.ami_type

  instance_types = [var.instance_types]
  disk_size      = var.disk_size

  remote_access {
    ec2_ssh_key = var.ec2_ssh_key
  }

  scaling_config {
    desired_size = var.blue_node_color == "blue" && var.blue ? var.desired_node : 0
    min_size     = var.blue_node_color == "blue" && var.blue ? var.node_min : 0
    max_size     = var.blue_node_color == "blue" && var.blue ? var.node_max : var.node_max
  }

  labels = {
    deployment_nodegroup = var.deployment_nodegroup
  }

  tags = merge(var.common_tags, {
    Name                                                    = format("%s-%s-%s-green-node-group", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    "k8s.io/cluster-autoscaler/${local.control_plane_name}" = "${var.shared_owned}"
    "k8s.io/cluster-autoscaler/enabled"                     = "${var.enable_cluster_autoscaler}"
    },
  )
}












