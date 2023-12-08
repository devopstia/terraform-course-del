resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-private-route-1", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_2.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-private-route-2", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}

resource "aws_route_table" "private_route_table_3" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-private-route-3", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}

resource "aws_route_table" "private_route_table_4" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_2.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-private-route-4", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}

resource "aws_route_table" "public_route_table_1" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-public-route-1", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}

resource "aws_route_table" "public_route_table_2" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-public-route-2", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}


