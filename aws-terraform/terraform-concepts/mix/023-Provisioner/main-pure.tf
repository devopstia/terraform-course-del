provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "web" {
	ami           = "ami-04bf6dcdc9ab498ca"
	instance_type = "t2.micro"
	key_name      = "jenkins-key"

	tags = {
		Name = "Tuts test"
	}

	connection {
		type        = "ssh"
		host        = aws_instance.web.public_ip
		user        = "ec2-user"
		private_key = file("C:\\Users\\Owner\\Downloads\\jenkins-key.pem")
		# Default timeout is 5 minutes
		timeout     = "4m"
	}

	provisioner "file" {
		content     = "Hello there"
		destination = "/tmp/tuts.txt"
	}

	provisioner "local-exec" {
		command = "echo ${aws_instance.web.public_ip} > instance-ip.txt"
	}

	provisioner "remote-exec" {
		inline = [
			"touch /tmp/tuts-remote-exec.txt"
		]
	}
}