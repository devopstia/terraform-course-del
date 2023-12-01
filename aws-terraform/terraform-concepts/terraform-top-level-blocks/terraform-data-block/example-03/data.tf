data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["default-vpc"]
  }
}

data "aws_subnet" "subnet01" {
  filter {
    name   = "tag:Name"
    values = ["default01"]
  }
}

data "aws_subnet" "subnet02" {
  filter {
    name   = "tag:Name"
    values = ["default02"]
  }
}

data "aws_subnet" "subnet03" {
  filter {
    name   = "tag:Name"
    values = ["default03"]
  }
}

data "aws_subnet" "subnet04" {
  filter {
    name   = "tag:Name"
    values = ["default04"]
  }
}

data "aws_subnet" "subnet05" {
  filter {
    name   = "tag:Name"
    values = ["default05"]
  }
}

data "aws_subnet" "subnet06" {
  filter {
    name   = "tag:Name"
    values = ["default06"]
  }
}

