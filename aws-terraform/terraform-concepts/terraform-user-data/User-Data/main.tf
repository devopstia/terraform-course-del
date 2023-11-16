provider "aws" {
  region = "us-east-1"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.tpl")}"
}

data "aws_vpc" "dev_vpc" {
  filter {
    name = "tag:Name"
    values = ["Dev VPC"]
  }
}


data "aws_subnet" "subnet_dev_vpc_public" {
  filter {
    name   = "tag:Name"
    values = ["Dev VPC Public Subnet"] 
  }
}


resource "aws_instance" "webserver" {
	ami               = var.ami
	key_name          = var.key_name
	instance_type     = var.instance_type
	subnet_id         = data.aws_subnet.subnet_dev_vpc_public.id
	security_groups   = [aws_security_group.webserver_sg.id]
	availability_zone = var.availability_zone
  user_data         = data.template_file.user_data.rendered
    
  tags = {
   Name = "dev-ec2"
  }
  
}
