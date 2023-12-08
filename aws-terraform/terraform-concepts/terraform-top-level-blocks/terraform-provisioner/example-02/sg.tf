resource "aws_security_group" "sg" {
  name_prefix = "sg"
  description = "Allow all inbound traffic from port 22 and 80"
  vpc_id      = "vpc-068852590ea4b093b"

  tags = {
    Name = "host SG"
  }
}

resource "aws_security_group_rule" "webserver_allow_all_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
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
