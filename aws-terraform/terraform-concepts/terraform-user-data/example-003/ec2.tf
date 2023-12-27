resource "aws_instance" "example" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  user_data              = file("${path.module}/website.sh")
  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name"           = "bastion-host"
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning an Training"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}