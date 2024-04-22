# data "azurerm_key_vault_secret" "example" {
#   name         = "my-secret"
#   key_vault_id = "/subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.KeyVault/vaults/<vault_name>"
# }

data "azurerm_key_vault_secret" "windows_admin_password" {
  name         = "2560-dev-del-aks-windows-password"
  key_vault_id = "/subscriptions/c344bf80-ed9d-4630-b1a7-4c9d3225a111/resourceGroups/2560-dev-del-key-vault/providers/Microsoft.KeyVault/vaults/dev-del-2560-kv"
}
