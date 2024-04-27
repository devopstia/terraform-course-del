data "azurerm_resource_group" "rg" {
  name = format("%s-%s-%s-rg", var.tags["id"], var.tags["environment"], var.tags["project"])
}

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = format("%s-%s-%s-aks", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = data.azurerm_resource_group.rg.name
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
  }
}