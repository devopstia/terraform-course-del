## Variable definiation
```s
variable "context" {
  description = "Input configuration for the Node groups"
  type = object({
    # EKS Cluster Config
    eks_cluster_id    = string
    cluster_ca_base64 = string
    cluster_endpoint  = string
    cluster_version   = string
    # VPC Config
    vpc_id             = string
    private_subnet_ids = list(string)
    public_subnet_ids  = list(string)
    # Security Groups
    worker_security_group_ids = list(string)

    # Data sources
    aws_partition_dns_suffix = string
    aws_partition_id         = string
    #IAM
    iam_role_path                 = string
    iam_role_permissions_boundary = string
    # Tags
    tags = map(string)
    # Service IPV4/IPV6 CIDR
    service_ipv6_cidr = string
    service_ipv4_cidr = string
  })
}
```

## Object with default values
```s
variable "context" {
  description = "Input configuration for the Node groups"
  type = object({
    eks_cluster_id    = string
    cluster_ca_base64 = string
    cluster_endpoint  = string
    cluster_version   = string
    vpc_id             = string
    private_subnet_ids = list(string)
    public_subnet_ids  = list(string)
    worker_security_group_ids = list(string)
    aws_partition_dns_suffix = string
    aws_partition_id         = string
    iam_role_path                 = string
    iam_role_permissions_boundary = string
    tags = map(string)
    service_ipv6_cidr = string
    service_ipv4_cidr = string
  })
  default = {
    eks_cluster_id            = ""
    cluster_ca_base64         = ""
    cluster_endpoint          = ""
    cluster_version           = ""
    vpc_id                    = ""
    private_subnet_ids        = []
    public_subnet_ids         = []
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
```

## terraform.tfvars
```s
context = {
  eks_cluster_id    = "your-cluster-id"
  cluster_ca_base64 = "base64-encoded-ca-data"
  cluster_endpoint  = "your-cluster-endpoint"
  cluster_version   = "your-cluster-version"
  vpc_id             = "your-vpc-id"
  private_subnet_ids = ["private-subnet-id-1", "private-subnet-id-2"]
  public_subnet_ids  = ["public-subnet-id-1", "public-subnet-id-2"]
  worker_security_group_ids = ["security-group-id-1", "security-group-id-2"]
  aws_partition_dns_suffix = "your-dns-suffix"
  aws_partition_id         = "your-partition-id"
  iam_role_path                 = "your-iam-role-path"
  iam_role_permissions_boundary = "your-iam-role-boundary"
  tags = {
    key1 = "value1",
    key2 = "value2",
  }
  service_ipv6_cidr = "your-ipv6-cidr"
  service_ipv4_cidr = "your-ipv4-cidr"
}
```

## example 
```s
# Define the 'context' variable
variable "context" {
  description = "Input configuration for the Node groups"
  type = object({
    eks_cluster_id    = string
    cluster_ca_base64 = string
    cluster_endpoint  = string
    cluster_version   = string
    vpc_id             = string
    private_subnet_ids = list(string)
    public_subnet_ids  = list(string)
    worker_security_group_ids = list(string)
    aws_partition_dns_suffix = string
    aws_partition_id         = string
    iam_role_path                 = string
    iam_role_permissions_boundary = string
    tags = map(string)
    service_ipv6_cidr = string
    service_ipv4_cidr = string
  })
  default = {
    eks_cluster_id            = ""
    cluster_ca_base64         = ""
    cluster_endpoint          = ""
    cluster_version           = ""
    vpc_id                    = ""
    private_subnet_ids        = []
    public_subnet_ids         = []
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

# Create an AWS EKS cluster using the 'context' variable
resource "aws_eks_cluster" "my_cluster" {
  name     = var.context.eks_cluster_id
  role_arn = "arn:aws:iam::123456789012:role/MyEKSRole"  # Replace with your EKS role ARN
  version  = var.context.cluster_version

  vpc_config {
    subnet_ids = values(var.context.private_subnet_ids)
  }
}

# Create an IAM role for worker nodes using the 'context' variable
resource "aws_iam_role" "my_worker_role" {
  name = "MyWorkerRole"
  path = var.context.iam_role_path

  permissions_boundary = var.context.iam_role_permissions_boundary
}

# Attach policies and configure other resources for your EKS cluster here
# ...

# Define tags for the EKS cluster using the 'context' variable
resource "aws_eks_cluster" "my_cluster" {
  for_each = var.context.tags

  cluster_name = aws_eks_cluster.my_cluster.name
  key         = each.key
  value       = each.value
}

# Define other resources and configurations based on your needs
# ...

```