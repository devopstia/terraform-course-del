# # Create route for private subnets to use NAT Gateway
# resource "azurerm_route" "private_route" {
#   count               = 3
#   name                = "private-route-${count.index + 1}"
#   resource_group_name = azurerm_resource_group.example.name
#   route_table_id      = azurerm_route_table.private_route_table[count.index].id

#   address_prefix         = "0.0.0.0/0"
#   next_hop_type          = "VirtualAppliance"
#   next_hop_in_ip_address = azurerm_nat_gateway.example[count.index].private_ip_address
# }

# resource "azurerm_route_table" "route_table" {
#   count               = 3
#   name                = "route-table-${count.index + 1}"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location

#   route {
#     name                   = "route-to-internet"
#     address_prefix         = "0.0.0.0/0"
#     next_hop_type          = "NatGateway"
#     next_hop_in_ip_address = azurerm_nat_gateway.example[count.index].public_ip_address # Use the first NAT gateway's public IP
#   }
# }

# resource "azurerm_subnet_route_table_association" "subnet_route_assoc" {
#   subnet_id      = azurerm_subnet.subnet.id
#   route_table_id = azurerm_route_table.route_table.id
# }