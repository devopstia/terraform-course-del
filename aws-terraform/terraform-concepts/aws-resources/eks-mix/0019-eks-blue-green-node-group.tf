variable "node_min" {
  type    = string
  default = "1"
}

variable "desired_node" {
  type    = string
  default = "1"
}

variable "node_max" {
  type    = string
  default = "6"
}

variable "blue_node_color" {
  type    = string
  default = "blue"
}

variable "green_node_color" {
  type    = string
  default = "green"
}

variable "blue" {
  type    = bool
  default = true
}

variable "green" {
  type    = bool
  default = false
}

resource "aws_eks_node_group" "green-nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "alpha-eks-green-node-group"
  node_role_arn   = aws_iam_role.nodes.arn

  version = "1.22"

  subnet_ids = [
    # aws_subnet.private_1.id,
    # aws_subnet.private_2.id,
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  capacity_type = "ON_DEMAND"
  ami_type      = "AL2_x86_64"
  # instance_types = ["t3.medium"]
  instance_types = ["t2.micro"]
  disk_size      = 20

  remote_access {
    ec2_ssh_key = "jenkins-key"
  }

  scaling_config {
    desired_size = var.green_node_color == "green" && var.green ? var.desired_node : 0
    min_size     = var.green_node_color == "green" && var.green ? var.node_min : 0
    max_size     = var.green_node_color == "green" && var.green ? var.node_max : var.node_max
  }

  labels = {
    deployment_nodegroup = "blue_green"
  }

  tags = {
    Name                                                  = "Apha Green Node Group"
    "k8s.io/cluster-autoscaler/${var.control_plane_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled "                  = "true"
  }
}


resource "aws_eks_node_group" "blue-nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "alpha-blue-node-group"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    # aws_subnet.private_1.id,
    # aws_subnet.private_2.id
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  version = "1.22"

  capacity_type  = "ON_DEMAND"
  ami_type       = "AL2_x86_64"
  instance_types = ["t3.medium"]
  # instance_types = ["t2.micro"]
  disk_size = 20

  remote_access {
    ec2_ssh_key = "jenkins-key"
  }

  scaling_config {
    desired_size = var.blue_node_color == "blue" && var.blue ? var.desired_node : 0
    min_size     = var.blue_node_color == "blue" && var.blue ? var.node_min : 0
    max_size     = var.blue_node_color == "blue" && var.blue ? var.node_max : var.node_max
  }

  labels = {
    deployment_nodegroup = "blue_green"
  }

  tags = {
    Name                                                  = "Apha Blue Node Group"
    "k8s.io/cluster-autoscaler/${var.control_plane_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled "                  = "true"
  }
}
















