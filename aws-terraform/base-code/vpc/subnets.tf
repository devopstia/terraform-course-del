
# Resource: aws_subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "eks-private-subnet-01" {
  depends_on = [
    aws_vpc.main
  ]
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "10.0.1.0/24"

  # The AZ for the subnet.
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "eks-private-subnet-01"

    # This is required by Kubernetes to discover subnets where private ELB will be created or to create load balancers in the private subnets
    "kubernetes.io/role/internal-elb" = "1"

    # You need to tag your cluster with the tag equal to EKS cluster name (demo-cluster). The value can be owned if you only use it for Kubernetes or share if you share it with other services or other EKS cluster  
    "kubernetes.io/cluster/demo-cluster" = "shared" # you need to tag your cluster with the tag equal to EKS cluster name. The value can be owned if you only use it for Kubernetes or share if you share it with other services or other EKS cluster

    # "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

# ---------------------------------------------------------------------------

resource "aws_subnet" "eks-private-subnet-02" {
  depends_on = [
    aws_vpc.main
  ]
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "10.0.2.0/24"

  # The AZ for the subnet.
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "eks-private-subnet-02"

    # This is required by Kubernetes to discover subnets where private ELB will be created or to create load balancers in the private subnets
    "kubernetes.io/role/internal-elb" = "1"

    # You need to tag your cluster with the tag equal to EKS cluster name (demo-cluster). The value can be owned if you only use it for Kubernetes or share if you share it with other services or other EKS cluster  
    "kubernetes.io/cluster/demo-cluster" = "shared" # you need to tag your cluster with the tag equal to EKS cluster name. The value can be owned if you only use it for Kubernetes or share if you share it with other services or other EKS cluster

    # "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

# ---------------------------------------------------------------------------

resource "aws_subnet" "eks-public-subnet-01" {
  depends_on = [
    aws_vpc.main
  ]

  # Enable EC2 to have public IP at launch time
  map_public_ip_on_launch = true

  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "10.0.3.0/24"

  # The AZ for the subnet.
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "eks-public-subnet-01"

    # This is required by Kubernetes to discover subnets where private ELB will be created or to create load balancers in the private subnets
    "kubernetes.io/role/elb" = "1"

    # You need to tag your cluster with the tag equal to EKS cluster name (demo-cluster). The value can be owned if you only use it for Kubernetes or share if you share it with other services or other EKS cluster  
    "kubernetes.io/cluster/demo-cluster" = "shared" # you need to tag your cluster with the tag equal to EKS cluster name. The value can be owned if you only use it for Kubernetes or share if you share it with other services or other EKS cluster

    # "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

# ---------------------------------------------------------------------------

resource "aws_subnet" "eks-public-subnet-02" {
  depends_on = [
    aws_vpc.main
  ]
  # Enable EC2 to have public IP at launch time
  map_public_ip_on_launch = true

  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "10.0.4.0/24"

  # The AZ for the subnet.
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "eks-public-subnet-02"

    # This is required by Kubernetes to discover subnets where private ELB will be created or to create load balancers in the private subnets
    "kubernetes.io/role/elb" = "1"

    # You need to tag your cluster with the tag equal to EKS cluster name (demo-cluster). The value can be owned if you only use it for Kubernetes or share if you share it with other services or other EKS cluster  
    "kubernetes.io/cluster/demo-cluster" = "shared" # you need to tag your cluster with the tag equal to EKS cluster name. The value can be owned if you only use it for Kubernetes or share if you share it with other services or other EKS cluster

    # "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}


# ---------------------------------------------------------------------------

resource "aws_subnet" "eks-db-subnet-01" {
  depends_on = [
    aws_vpc.main
  ]
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "10.0.5.0/24"

  # The AZ for the subnet.
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "eks-db-subnet-01"
  }
}

# ---------------------------------------------------------------------------

resource "aws_subnet" "eks-db-subnet-02" {
  depends_on = [
    aws_vpc.main
  ]
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  # The CIDR block for the subnet.
  cidr_block = "10.0.6.0/24"

  # The AZ for the subnet.
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "eks-db-subnet-02"
  }
}

















