resource "azurerm_kubernetes_cluster_node_pool" "linux_pool" {
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks_cluster.id
  name                  = "linuxpool"
  mode                  = "User"
  vm_size               = "Standard_DS2_v2"
  os_type               = "Linux"
  vnet_subnet_id        = data.azurerm_subnet.existing_subnet.id
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  priority              = "Regular"
  enable_auto_scaling   = true
  max_count             = 3
  min_count             = 1
  os_disk_size_gb       = 30

  node_labels = {
    "nodepool-type" = "linuxpool"
    "environment"   = "dev"
    "nodepoolos"    = "linux"
    "app"           = "alpha"
  }
  tags = var.tags
}