
resource "azurerm_key_vault_secret" "client_secret" {
  name         = format("%s-%s-%s-aks-windows-password", var.tags["id"], var.tags["environment"], var.tags["project"])
  value        = "DevOpsEasyLearning@102"
  key_vault_id = data.azurerm_key_vault.main.id
}