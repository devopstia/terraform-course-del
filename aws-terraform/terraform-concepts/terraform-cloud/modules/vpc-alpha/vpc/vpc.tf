# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}
