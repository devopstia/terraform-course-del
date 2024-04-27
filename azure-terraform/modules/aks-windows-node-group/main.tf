resource "azurerm_kubernetes_cluster_node_pool" "windows_pool" {
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks_cluster.id
  name                  = "wpool"
  mode                  = "User"
  vm_size               = "Standard_DS2_v2"
  os_type               = "Windows"
  vnet_subnet_id        = data.azurerm_subnet.existing_subnet.id
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  priority              = "Regular"
  enable_auto_scaling   = true
  max_count             = 3
  min_count             = 1
  os_disk_size_gb       = 60 # Update June 2023

  node_labels = {
    "nodepool-type" = "windowspool"
    "environment"   = "dev"
    "nodepoolos"    = "windows"
    "app"           = "dotnet-apps"
  }
  tags = var.tags
}