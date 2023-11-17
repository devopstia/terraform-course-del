resource "aws_security_group" "sg" {
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-${var.sg_name}", var.tags["id"], var.tags["environment"], var.tags["project"])
  })
}

resource "aws_security_group_rule" "webserver_allow_all_inbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "webserver_allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}
