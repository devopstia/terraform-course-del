resource "aws_eip" "nat1" {
  vpc = true
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc-nat-eip-01", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

resource "aws_eip" "nat2" {
  vpc = true
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc-nat-eip-02", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

resource "aws_eip" "nat3" {
  vpc = true
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-vpc-nat-eip-03", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}
