provider "aws" {
  region     = "us-east-1"
}

resource "aws_vpc" "ProdVpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Production"
  }
}

resource "aws_security_group" "allow_port_8080" {
  name        = "allow_port_8080"
  description = "Allow allow port 8080 inbound traffic"
  vpc_id      = aws_vpc.ProdVpc.id

  ingress {
    description = "allow port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow port 8080"
  }
}

resource "aws_security_group" "allow_port_3306" {
  name        = "allow_port_3306"
  description = "Allow allow port 3306 inbound traffic from web server 8080"
  vpc_id      = aws_vpc.ProdVpc.id

  // allow traffic for TCP 3306
  ingress {
    description = "allow port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_port_8080.id]
  }

  // outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow port 3306"
  }
}
