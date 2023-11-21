resource "aws_internet_gateway" "main" {
  depends_on = [
    aws_vpc.main
  ]
  vpc_id = aws_vpc.main.id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc-internet-gateway", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

