resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc-public-route", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

resource "aws_route_table" "private-01" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw1.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc-public-route-01", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

resource "aws_route_table" "private-02" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw2.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc-public-route-02", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

resource "aws_route_table" "private-03" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw3.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc-public-route-03", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

