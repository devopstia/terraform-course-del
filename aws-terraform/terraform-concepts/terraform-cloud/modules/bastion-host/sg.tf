resource "aws_security_group" "example" {
  name_prefix = format("%s-%s-%s-ec2-sg", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
  vpc_id      = data.aws_vpc.alpha-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-ec2-sg", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}
