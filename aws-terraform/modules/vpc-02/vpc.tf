resource "aws_vpc" "main" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}



