# Documentation Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions
# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  version_prefix  = var.version_prefix
  include_preview = false
}

data "azurerm_resource_group" "rg" {
  name = format("%s-%s-%s-rg", var.tags["id"], var.tags["environment"], var.tags["project"])
}

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = format("%s-%s-%s-aks", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = data.azurerm_resource_group.rg.name
}

