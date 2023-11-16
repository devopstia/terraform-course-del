provider "aws" {
    region = "us-east-1"
}

# 1. Create a vpc

resource "aws_vpc" "ProdVpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Production"
  }
}

# 2. Create an internet gateway and associate to the VPC

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ProdVpc.id
  tags = {
    Name = "main"
  }
}

# 3. Create custom route table
resource "aws_route_table" "PordRouteTable" {
  vpc_id = aws_vpc.ProdVpc.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "MyProRoute"
  }
}

# 4. Create a subnet
resource "aws_subnet" "PuiblicSubnet1" {
  vpc_id            =  aws_vpc.ProdVpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "ProdSubnet"
  }
}

# 5. Associate subnet with route table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.PuiblicSubnet1.id
  route_table_id = aws_route_table.PordRouteTable.id
}

# 6- Create a SG and allow port 22, 80, 443
resource "aws_security_group" "allow-web" {
    name              = "all_web_traffic"
    description       = "Allow port 22, 80, 443"
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
