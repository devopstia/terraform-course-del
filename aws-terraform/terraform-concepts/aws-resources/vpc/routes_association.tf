# Associate the public subnets with the corresponding route tables
resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table_1.id
}

resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table_2.id
}

# Associate the private subnets with their corresponding route tables
resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table_2.id
}

resource "aws_route_table_association" "private_route_table_association_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_route_table_association_4" {
  subnet_id      = aws_subnet.private_subnet_4.id
  route_table_id = aws_route_table.private_route_table_2.id
}
