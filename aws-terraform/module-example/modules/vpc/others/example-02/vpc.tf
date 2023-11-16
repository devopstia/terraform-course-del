resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false

  tags = merge(map("Name", format("%s-vpc", var.tags["environment"])), var.tags)
}

######################################################
# Enable access to or from the Internet for instances
# in public subnets
######################################################
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags = merge(map("Name", format("%s-internet-gateway", var.tags["environment"])), var.tags)
}
