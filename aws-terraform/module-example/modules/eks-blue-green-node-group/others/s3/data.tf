data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-vpc"]
  }
}

data "aws_subnet" "private_subnet1" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-vpc-private-subnet-eks-ec2-01"]
  }
}

data "aws_subnet" "private_subnet2" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-vpc-private-subnet-eks-ec2-02"]
  }
}

data "aws_subnet" "public_1" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-vpc-public-subnet-01"]
  }
}

data "aws_subnet" "public_2" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-vpc-public-subnet-02"]
  }
}

data "aws_eks_cluster" "example" {
  name = "2560-dev-alpha"
}

output "eks_cluster_name" {
  value = data.aws_eks_cluster.example.name
}
