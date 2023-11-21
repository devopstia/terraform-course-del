resource "aws_nat_gateway" "gw1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public-subnet-01.id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-nat-01", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

resource "aws_nat_gateway" "gw2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.public-subnet-02.id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-nat-02", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

resource "aws_nat_gateway" "gw3" {
  allocation_id = aws_eip.nat3.id
  subnet_id     = aws_subnet.public-subnet-02.id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-nat-02", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}


