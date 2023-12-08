# Allocate Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip_1" {
  vpc = true
}

resource "aws_eip" "nat_eip_2" {
  vpc = true
}
