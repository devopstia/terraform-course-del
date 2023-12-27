resource "aws_security_group" "example_sg" {
  name        = "example_sg"
  description = "Example security group for port 22 inbound and all outbound"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id
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
}
