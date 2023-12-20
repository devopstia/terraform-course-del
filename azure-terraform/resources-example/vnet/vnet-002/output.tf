
# Output public subnets
output "public_subnets" {
  value = azurerm_subnet.public_subnet[*].id
}

# Output private subnets
output "private_subnets" {
  value = azurerm_subnet.private_subnet[*].id
}

# NAT IS
output "nat_ids" {
  value = azurerm_nat_gateway.example[*].id
}