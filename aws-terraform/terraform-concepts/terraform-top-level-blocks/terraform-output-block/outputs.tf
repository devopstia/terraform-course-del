output "instance_id" {
  description = "The ID of the AWS EC2 instance"
  value       = aws_instance.example.id
}

output "private_ip" {
  description = "The private IP address of the AWS EC2 instance"
  value       = aws_instance.example.private_ip
}

output "public_ip" {
  description = "The public IP address of the AWS EC2 instance"
  value       = aws_instance.example.public_ip
}

output "instance_type" {
  description = "The type of the AWS EC2 instance"
  value       = aws_instance.example.instance_type
}

output "subnet_id" {
  description = "The ID of the subnet where the AWS EC2 instance is deployed"
  value       = aws_instance.example.subnet_id
}

output "security_group_ids" {
  description = "A list of security group IDs associated with the AWS EC2 instance"
  value       = aws_instance.example.security_groups
}


