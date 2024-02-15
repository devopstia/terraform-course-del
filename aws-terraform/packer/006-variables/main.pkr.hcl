
source "amazon-ebs" "ubuntu" {
  ami_name           = "${var.ami_name}-{{timestamp}}"
  instance_type      = var.instance_type
  region             = var.region
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
  security_group_ids = [var.security_group_ids]

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
      name                = "ubuntu/images/hvm-ssd/*ubuntu-*22.04-amd64-server*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  tags = var.tags
}
build {
  name    = "Installing Packages"
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