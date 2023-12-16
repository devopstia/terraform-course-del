output "subnet_ids" {
  value = aws_subnet.subnets[*].id
}

output "subnet_cidr_blocks" {
  value = aws_subnet.subnets[*].cidr_block
}

output "subnet_availability_zones" {
  value = aws_subnet.subnets[*].availability_zone
}
