
resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_params["instance_type"]
  key_name               = var.instance_params["key_name"]
  vpc_security_group_ids = [var.instance_params["vpc_security_group_ids"]]
  subnet_id              = var.instance_params["subnet_id"]
  root_block_device {
    volume_size = var.instance_params["volume_size"]
  }
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-${var.instance_name}", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}