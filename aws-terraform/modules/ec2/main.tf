
locals {
  selected_ami = var.distribution == "redhat" ? data.aws_ami.rhel.id : var.distribution == "ubuntu" ? data.aws_ami.ubuntu.id : var.distribution == "amazon-linux" ? data.aws_ami.amzlinux.id : var.distribution == "windows" ? data.aws_ami.windows.id : null
}

resource "aws_instance" "vm" {
  count                   = var.instance_count
  ami                     = local.selected_ami
  instance_type           = var.ec2_instance_type
  key_name                = var.ec2_instance_key_name
  vpc_security_group_ids  = [aws_security_group.sg.id]
  subnet_id               = var.subnet_id
  disable_api_termination = var.enable_termination_protection

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-${var.instance_name}-${count.index + 1}", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}
