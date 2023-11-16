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

resource "aws_security_group" "allow-web" {
    name              = "all_web_traffic"
    description       = "Allow port 22, 80, 8080, 443"
    vpc_id            = aws_vpc.ProdVpc.id
    ingress {
        description       = "HTTPS"
        from_port         = 443
        to_port           = 443
        protocol          = "tcp"
        cidr_blocks       = ["0.0.0.0/0"]
    }
     ingress {
        description       = "HTTP"
        from_port         = 80
        to_port           = 80
        protocol          = "tcp"
        cidr_blocks       = ["0.0.0.0/0"]

    }
     ingress {
        description       = "HTTP"
        from_port         = 8080
        to_port           = 8080
        protocol          = "tcp"
        cidr_blocks       = ["0.0.0.0/0"]
    }
     ingress {
        description       = "SSH"
        from_port         = 22
        to_port           = 22
        protocol          = "tcp"
        cidr_blocks       = ["0.0.0.0/0"]
    }
    egress {
        from_port         = 0
        to_port           = 0
        protocol          = "-1"
        cidr_blocks       = ["0.0.0.0/0"]
    }
    tags = {
        Name = "SG-web"
    }
}


resource "aws_security_group" "allow-DB" {
    name              = "all_DB_traffic"
    description       = "Allow port 3306 from all_web_traffic SG"
    vpc_id            = aws_vpc.ProdVpc.id
     ingress {
        description       = "allow port 3306"
        from_port         = 3306
        to_port           = 3306
        protocol          = "tcp"
        security_groups = [aws_security_group.allow-web.id]
    }
    egress {
        from_port         = 0
        to_port           = 0
        protocol          = "-1"
        cidr_blocks       = ["0.0.0.0/0"]
    }
    tags = {
        Name = "SG-DB"
    }
}


resource "aws_instance" "web-server-instance" {
  ami               = "ami-0947d2ba12ee1ff75"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "jenkins-key"
  //vpc_id            = aws_vpc.ProdVpc.id

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo your very first web server > /var/www/html/index.html'
                EOF
  tags = {
    Name = "web-server"
  }
}

resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web-server-instance.id
  allocation_id = aws_eip.lb.id
}