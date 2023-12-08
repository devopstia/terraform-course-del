# EC2 Instance
resource "aws_instance" "jenkins" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.medium"
  # user_data              = file("${path.module}/jenkins-script/jenkins-master.sh")
  key_name               = "terraform-aws"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  tags = {
    "Name" = "jenkins-host"
  }
}

# Create Elastic IP for jenkins Host
resource "aws_eip" "jenkins_eip" {
  depends_on = [aws_instance.jenkins]
  instance   = aws_instance.jenkins.id
  vpc        = true
  tags = {
    "Name" = "jenkins Pulic IP"
  }
}

# Create a Null Resource and Provisioners
resource "null_resource" "connection" {
  depends_on = [aws_instance.jenkins]
  connection {
    type        = "ssh"
    host        = aws_eip.jenkins_eip.public_ip
    user        = "ubuntu"
    password    = ""
    private_key = file("private-key/terraform-aws.pem")
  }

  provisioner "file" {
    source      = "./jenkins-script/jenkins-master.sh"
    destination = "/home/ubuntu/jenkins-master.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/jenkins-master.sh",
      "sudo bash /home/ubuntu/jenkins-master.sh"
    ]
  }
}
