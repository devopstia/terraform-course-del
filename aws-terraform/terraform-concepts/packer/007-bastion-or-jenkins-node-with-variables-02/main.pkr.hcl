
source "amazon-ebs" "ubuntu" {
  ami_name                    = format("%s-%s-%s-${var.ami_name}-{{timestamp}}", var.tags["id"], var.tags["environment"], var.tags["project"])
  instance_type               = var.instance_type
  region                      = var.region
  vpc_id                      = var.vpc_id
  subnet_id                   = var.subnet_id
  security_group_ids          = [var.security_group_ids]
  # source_ami                  = var.source_ami
  ssh_username                = var.ssh_username
  ssh_port                    = 22
  ssh_timeout                 = "10m"
  associate_public_ip_address = true

  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = var.volume_size
    volume_type = "gp2"
  }
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/*ubuntu-*${var.release_version}-amd64-server*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-${var.ami_name}", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}
build {
  name    = format("%s-%s-%s-${var.ami_name}", var.tags["id"], var.tags["environment"], var.tags["project"])
  sources = ["source.amazon-ebs.ubuntu"]
  provisioner "file" {
    source      = "./scripts/script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "shell" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "sudo bash +x /tmp/script.sh",
    ]
  }
}