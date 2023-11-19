data "aws_vpc" "adl_eks_vpc" {
  filter {
    name   = "tag:Name"
    values = ["adl-eks-vpc"]
  }
}

data "aws_subnet" "eks-db-subnet-01" {
  filter {
    name   = "tag:Name"
    values = ["eks-db-subnet-01"]
  }
}

data "aws_subnet" "eks-db-subnet-02" {
  filter {
    name   = "tag:Name"
    values = ["eks-db-subnet-02"]
  }
}
