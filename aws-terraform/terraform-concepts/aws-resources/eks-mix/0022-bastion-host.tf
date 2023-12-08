
# # Get latest AMI ID for Amazon Linux2 OS
# data "aws_ami" "amzlinux2" {
#   most_recent = true
#   owners      = ["amazon"]
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-gp2"]
#   }
#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }
# }



# resource "aws_security_group" "ssh_http_sg" {
#   name_prefix = "ssh-http-sg"
#   description = "Allow all inbound traffic from port 22 and 80"
#   vpc_id      = aws_vpc.main.id

#   tags = {
#     Name = "SSH and HTTP SG"
#   }

# #   lifecycle {
# #     create_before_destroy = true
# #   }
# }

# resource "aws_security_group_rule" "webserver_allow_all_ssh" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.ssh_http_sg.id
# }

# resource "aws_security_group_rule" "webserver_allow_all_http" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.ssh_http_sg.id
# }

# resource "aws_security_group_rule" "webserver_allow_all_ping" {
#   type              = "ingress"
#   from_port         = 8
#   to_port           = 0
#   protocol          = "icmp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.ssh_http_sg.id
# }

# resource "aws_security_group_rule" "webserver_allow_all_outbound" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.ssh_http_sg.id
# }


# # EC2 Instance
# resource "aws_instance" "bastion" {
#   ami                    = data.aws_ami.amzlinux2.id
#   instance_type          = "t2.micro"
#   user_data              = file("${path.module}/bastion-user-data/bastion-host-user-data.sh")
#   key_name               = "jenkins-key"
#   vpc_security_group_ids = [aws_security_group.ssh_http_sg.id]

#   subnet_id = aws_subnet.public_1.id

#   tags = {
#     "Name" = "bastion-host"
#   }
# }


# # Create Elastic IP for Bastion Host
# resource "aws_eip" "bastion_eip" {
#   instance = aws_instance.bastion.id
#   vpc      = true
#   tags = {
#     "Name" = "Bastion Pulic IP"
#   }
# }


# # Create a Null Resource and Provisioners
# resource "null_resource" "copy_ec2_keys" {
#   depends_on = [aws_instance.bastion]
#   # Connection Block for Provisioners to connect to EC2 Instance
#   connection {
#     type        = "ssh"
#     host        = aws_eip.bastion_eip.public_ip
#     user        = "ec2-user"
#     password    = ""
#     private_key = file("private-key/jenkins-key.pem")
#   }

#   ## File Provisioner: Copies the jenkins-key.pem file to /tmp/jenkins-key.pem
#   provisioner "file" {
#     source      = "private-key/jenkins-key.pem"
#     destination = "/tmp/jenkins-key.pem"
#   }
#   ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod 400 /tmp/jenkins-key.pem"
#     ]
#   }
# }
