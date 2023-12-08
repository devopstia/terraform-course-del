data "aws_vpc" "alpha-vpc" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha"]
  }
}

data "aws_subnet" "private01" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-private-subnet-1"]
  }
}

data "aws_subnet" "private02" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-private-subnet-2"]
  }
}
