# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal

data "azuread_client_config" "current" {}

data "azurerm_key_vault" "main" {
  name                = "dev-del-2560-kv"
  resource_group_name = "2560-dev-del-key-vault"
}

resource "azuread_application" "main" {
  display_name = format("%s-%s-%s-terraform", var.tags["id"], var.tags["environment"], var.tags["project"])
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "main" {
  client_id = azuread_application.main.application_id
  # True allow us to provide contributor access to this service pricipal
  app_role_assignment_required = true
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.object_id
}

resource "azurerm_role_assignment" "contributor" {
  scope                = "/subscriptions/${var.subscription_id}"
  principal_id         = azuread_service_principal.main.object_id
  role_definition_name = "Contributor"
}

resource "azurerm_key_vault_secret" "client_secret" {
  name         = format("%s-%s-%s-terraform-client-secret", var.tags["id"], var.tags["environment"], var.tags["project"])
  value        = azuread_service_principal_password.main.value
  key_vault_id = data.azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "application_id" {
  name         = format("%s-%s-%s-terraform-application-id", var.tags["id"], var.tags["environment"], var.tags["project"])
  value        = azuread_application.main.application_id
  key_vault_id = data.azurerm_key_vault.main.id
}