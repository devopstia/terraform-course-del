# Create Log Analytics Workspace
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = format("%s-%s-%s-log-analytics", var.tags["id"], var.tags["environment"], var.tags["project"])
  location            = format("%s", var.tags["location"])
  resource_group_name = data.azurerm_resource_group.rg.name
  retention_in_days   = 30
}