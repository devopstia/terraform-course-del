resource "aws_route_table_association" "public_01" {
  subnet_id      = aws_subnet.public-subnet-01.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_02" {
  subnet_id      = aws_subnet.public-subnet-02.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_03" {
  subnet_id      = aws_subnet.public-subnet-03.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private_01" {
  subnet_id      = aws_subnet.private-subnet-01.id
  route_table_id = aws_route_table.private-01.id
}

resource "aws_route_table_association" "private_02" {
  subnet_id      = aws_subnet.private-subnet-02.id
  route_table_id = aws_route_table.private-02.id
}

resource "aws_route_table_association" "private_03" {
  subnet_id      = aws_subnet.private-subnet-03.id
  route_table_id = aws_route_table.private-03.id
}
