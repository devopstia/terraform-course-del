# Resource: aws_eks_cluster
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

resource "aws_eks_cluster" "eks" {
  # Name of the cluster.
  name = "eks"

  # The Amazon Resource Name (ARN) of the IAM role that provides permissions for 
  # the Kubernetes control plane to make calls to AWS API operations on your behalf
  role_arn = aws_iam_role.demo.arn

  # Desired Kubernetes master version
  version = "1.22"

  vpc_config {
    # Indicates whether or not the Amazon EKS private API server endpoint is enabled
    endpoint_private_access = false

    # Indicates whether or not the Amazon EKS public API server endpoint is enabled
    endpoint_public_access = true
    public_access_cidrs    = ["0.0.0.0/0"]

    # Must be in at least two different availability zones
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      # aws_subnet.private_1.id,
      # aws_subnet.private_1.id
    ]
    security_group_ids = [
      aws_security_group.control-plane-sg.id,
    ]
  }

  # Enable EKS Cluster Control Plane Logging
  # This is helpfull for troubleshooting. We can directly see the logs of those components in AWS CloudWash when the EKS control plane is created
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  # depends_on = [
  #   aws_security_group.control-plane-sg,
  #   aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy,
  #   aws_iam_role_policy_attachment.demo-AmazonEKSVPCResourceController,
  # ]

  tags = {
    Name = "EKS Control Plane"
  }
}

