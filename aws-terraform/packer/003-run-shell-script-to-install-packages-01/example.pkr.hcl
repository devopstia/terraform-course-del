source "amazon-ebs" "ubuntu" {
  ami_name           = "ubuntu-with-updates-{{timestamp}}"
  instance_type      = "t2.micro"
  region             = "us-east-1"
  vpc_id             = "vpc-068852590ea4b093b"
  subnet_id          = "subnet-096d45c28d9fb4c14"
  security_group_ids = ["sg-0c51540c60857b7ed"]
  source_ami         = "ami-06aa3f7caf3a30282" #Version 22.04

  ssh_username = "ubuntu"
  ssh_port     = 22
  ssh_timeout  = "10m"
  associate_public_ip_address = true

  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 20
    volume_type = "gp2"
  }
  tags = {
    "Name"           = "ubuntu-ami"
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
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

