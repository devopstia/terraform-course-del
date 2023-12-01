## Base
```s
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vm" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}
```

##
```s
variable "context" {
  description = "Input configuration for the Node groups"
  type        = any
  default = {
    eks_cluster_id            = ""
    cluster_ca_base64         = ""
    cluster_endpoint          = ""
    cluster_version           = ""
    vpc_id                    = ""
    private_subnet_ids        = {}
    public_subnet_ids         = {}
    worker_security_group_ids = []
    aws_partition_dns_suffix = ""
    aws_partition_id         = ""
    iam_role_path                 = ""
    iam_role_permissions_boundary = ""
    tags                      = {}
    service_ipv6_cidr         = ""
    service_ipv4_cidr         = ""
  }
}


variable "context" {
  description = "Input configuration for the Node groups"
  type        = any
  default = {
    eks_cluster_id            = "my-cluster-id"
    cluster_ca_base64         = "my-base64-ca"
    cluster_endpoint          = "https://my-cluster-endpoint.com"
    cluster_version           = "1.21"
    vpc_id                    = "vpc-12345678"
    private_subnet_ids = {
      subnet1 = "subnet-abcdefg"
      subnet2 = "subnet-hijklmn"
    }
    public_subnet_ids = {
      subnet1 = "subnet-opqrstuv"
      subnet2 = "subnet-wxyz1234"
    }
    worker_security_group_ids = ["sg-12345678"]
    aws_partition_dns_suffix  = "amazonaws.com"
    aws_partition_id          = "aws"
    iam_role_path             = "/my-iam-path/"
    iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/MyBoundaryPolicy"
    tags = {
      Name        = "MyCluster"
      Environment = "Production"
    }
    service_ipv6_cidr         = "2001:db8:abcd:123::/64"
    service_ipv4_cidr         = "10.0.0.0/16"
  }
}
```

```s
locals {
  aws_region = "us-east-1"

  control_plane_name = "2560-dev-del"
  private_subnets = {
    us-east-1a = "subnet-096d45c28d9fb4c14"
    us-east-1b = "subnet-05f285a35173783b0"
    us-east-1c = "subnet-0fe3255479ad7c3a4"
  }

  eks_version  = "1.24"
  node_min     = "1"
  desired_node = "1"
  node_max     = "6"

  ec2_ssh_key               = "terraform"
  deployment_nodegroup      = "blue_green"
  capacity_type             = "ON_DEMAND"
  ami_type                  = "AL2_x86_64"
  instance_types            = "t2.micro"
  disk_size                 = "10"
  shared_owned              = "shared"
  enable_cluster_autoscaler = "true"

  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}
```

