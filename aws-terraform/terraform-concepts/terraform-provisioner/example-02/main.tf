# Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example_instance" {
  ami                    = data.aws_ami.ubuntu_20_04.id
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = 10
  }

  tags = {
    "Name" = "TerraformInstance"
  }
}

resource "aws_ebs_volume" "example_volume" {
  availability_zone = "us-east-1a"
  size              = 30
  type              = "gp2"
  encrypted         = true

  tags = {
    "Name" = "TerraformEBSVolume"
  }
}

resource "aws_volume_attachment" "example_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.example_volume.id
  instance_id = aws_instance.example_instance.id
}

# Create a Null Resource and Provisioners
resource "null_resource" "connection" {
  depends_on = [aws_volume_attachment.example_attachment]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.example_instance.public_ip
      user        = "ubuntu"
      private_key = file("private-key/terraform-aws.pem")
    }

    inline = [
      "sudo mkfs.ext4 /dev/xvdf",                                          # Format the EBS volume
      "sudo mkdir /data",                                                  # Create a mount point
      "sudo mount /dev/xvdf /data",                                        # Mount the volume
      "echo '/dev/xvdf /data ext4 defaults 0 0' | sudo tee -a /etc/fstab", # Add an entry to /etc/fstab for auto-mounting
      "sudo mount -a",
      "lsblk -l"
    ]
  }
}
