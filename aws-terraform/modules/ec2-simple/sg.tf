resource "aws_security_group" "sg" {
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-${var.sg_name}", var.tags["id"], var.tags["environment"], var.tags["project"])
  })
}

resource "aws_security_group_rule" "allowed_ports_rules" {
  for_each = { for idx, port in var.allowed_ports : idx => port }

  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "webserver_allow_all_ping" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
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
