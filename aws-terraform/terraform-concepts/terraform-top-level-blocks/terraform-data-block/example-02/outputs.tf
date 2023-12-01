output "vpc" {
  value = data.aws_vpc.vpc.id
}

output "subnet01" {
  value = data.aws_subnet.subnet01.id
}

output "subnet02" {
  value = data.aws_subnet.subnet02.id
}

output "subnet03" {
  value = data.aws_subnet.subnet03.id
}

output "subnet04" {
  value = data.aws_subnet.subnet04.id
}

output "subnet05" {
  value = data.aws_subnet.subnet05.id
}

output "subnet06" {
  value = data.aws_subnet.subnet06.id
}

output "allow-all-traffic-sg" {
  value = data.aws_security_group.allow-all-traffic-sg.id
}
