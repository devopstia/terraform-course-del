resource "aws_instance" "example" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = data.aws_subnet.public02.id
  vpc_security_group_ids = [aws_security_group.example.id]
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 10
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-bastion-host", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}


