locals {
  name = "${terraform.workspace}-vm"
}

resource "aws_instance" "vm" {
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_instance_key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name      = local.name
    Create_By = "Terraform"
  }
}