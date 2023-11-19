variable "aws_instance" {
  type        = map(any)
  description = "Map of RDS Instances and their values"
  default = {
    ami           = "ami-052efd3df9dad4825"
    instance_type = "t2.micro"
  }
}


module "ec2-instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  version       = "4.3.0"
  ami           = lookup(var.aws_instance, "ami", "null")
  instance_type = lookup(var.aws_instance, "instance_type", "t2.smal")
  tags = {
    Name = "web01"
  }
}

