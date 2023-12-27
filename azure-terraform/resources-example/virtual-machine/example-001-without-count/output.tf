## Public IP Address
output "web_linuxvm_public_ip" {
  description = "Linux VM Public Address"
  value       = azurerm_public_ip.public-ip.ip_address
}

# output "tls_private_key" {
#   value = tls_private_key.example_ssh.private_key_pem
# }
