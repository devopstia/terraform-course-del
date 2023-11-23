instance_configs = {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  volume_size            = "10"
  tags = {
    Name      = "vm-1"
    Create_By = "Terraform"
  }
}
