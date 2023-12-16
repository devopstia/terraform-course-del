output "instance_ids" {
  value = aws_instance.example[*].id
}

output "instance_public_ips" {
  value = aws_instance.example[*].public_ip
}

output "instance_private_ips" {
  value = aws_instance.example[*].private_ip
}

output "instance_names" {
  value = aws_instance.example[*].tags.Name
}
