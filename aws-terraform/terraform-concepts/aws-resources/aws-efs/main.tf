provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Resource: Security Group - Allow Inbound NFS Traffic from EKS VPC CIDR to EFS File System
resource "aws_security_group" "efs_allow_access" {
  name        = "efs-allow-nfs-from-eks-vpc"
  description = "Allow Inbound NFS Traffic from EKS VPC CIDR"
  vpc_id      = "vpc-068852590ea4b093b"

  ingress {
    description = "Allow Inbound NFS Traffic from EKS VPC CIDR to EFS File System"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_nfs_from_eks_vpc"
  }
}

# Resource: EFS File System
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system
resource "aws_efs_file_system" "efs_file_system" {
  creation_token = "efs-demo"
  encrypted      = true
  tags = {
    Name = "efs-demo"
  }
}

# Resource: EFS Mount Target
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target
resource "aws_efs_mount_target" "efs_mount_target1" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = "subnet-096d45c28d9fb4c14"
  security_groups = [aws_security_group.efs_allow_access.id]
}

# Resource: EFS Mount Target
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target
resource "aws_efs_mount_target" "efs_mount_target2" {
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = "subnet-05f285a35173783b0"
  security_groups = [aws_security_group.efs_allow_access.id]
}


# EFS File System ID
output "efs_file_system_id" {
  description = "EFS File System ID"
  value       = aws_efs_file_system.efs_file_system.id
}

output "efs_file_system_dns_name" {
  description = "EFS File System DNS Name"
  value       = aws_efs_file_system.efs_file_system.dns_name
}

# EFS Mounts Info
output "efs_mount_target_id1" {
  description = "EFS File System Mount Target ID"
  value       = aws_efs_mount_target.efs_mount_target1.id
}

# EFS Mounts Info
output "efs_mount_target_id2" {
  description = "EFS File System Mount Target ID"
  value       = aws_efs_mount_target.efs_mount_target2.id
}

output "efs_mount_target_dns_name1" {
  description = "EFS File System Mount Target DNS Name"
  value       = aws_efs_mount_target.efs_mount_target1.mount_target_dns_name
}

output "efs_mount_target_dns_name2" {
  description = "EFS File System Mount Target DNS Name"
  value       = aws_efs_mount_target.efs_mount_target2.mount_target_dns_name
}
