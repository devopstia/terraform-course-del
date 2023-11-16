provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "web" {
	ami           = "ami-04bf6dcdc9ab498ca"
	instance_type = "t2.micro"
	key_name      = "jenkins-key"
	
	tags = {
		Name = "test"
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
		source      = "C:\\Users\\Owner\\Downloads\\jenkins-key.pem"
		destination = "/tmp/jenkins-key.pem"
		
	}

	provisioner "file" {
		source      = "httpd.sh"
		destination = "/tmp/httpd.sh"
		
	}

	provisioner "remote-exec" {
		inline = [
			"cd /tmp",
			"sudo chmod 600 jenkins-key.pem",
			"sudo chmod +x httpd.sh",
			"sudo bash httpd.sh"
		]
	}
}


# How can I use Terraform's file provisioner to copy from my local machine onto a VM?
/*
resource "null_resource" remoteExecProvisionerWFolder {

  provisioner "file" {
    source      = "test.txt"
    destination = "/tmp/test.txt"
  }

  connection {
    host     = "${azurerm_virtual_machine.vm.ip_address}"
    type     = "ssh"
    user     = "${var.admin_username}"
    password = "${var.admin_password}"
    agent    = "false"
  }
}
*/