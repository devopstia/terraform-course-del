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
    Name      = "vm"
    Create_By = "Terraform"
  }
}

resource "random_string" "bucket_suffix" {
  length  = var.bucket_suffix_length
  special = var.bucket_suffix_special
  upper   = var.bucket_suffix_upper
  number  = var.bucket_suffix_number
}
