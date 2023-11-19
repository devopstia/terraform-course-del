data "aws_vpc" "bamboo_vpc" {
  filter {
    name   = "tag:Name"
    values = ["Tia-public"]
  }
}

data "aws_subnet" "db-subnet-public-01" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-01"]
  }
}

data "aws_subnet" "db-subnet-public-02" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet-02"]
  }
}


data "aws_ssm_parameter" "bamboo-db-password" {
  name = "${var.param_store_prefix}/bamboo-db-password"
}
