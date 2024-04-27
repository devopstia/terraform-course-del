resource "azurerm_kubernetes_cluster_node_pool" "linux_pool" {
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks_cluster.id
  name                  = "spot"
  mode                  = "User"
  vm_size               = "Standard_DS2_v2"
  os_type               = "Linux"
  vnet_subnet_id        = data.azurerm_subnet.existing_subnet.id
  orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  priority              = "Spot"
  spot_max_price        = -1
  eviction_policy       = "Delete"
  enable_auto_scaling   = true
  node_count            = 1
  min_count             = 1
  max_count             = 10
  os_disk_size_gb       = 30

  node_labels = {
    role                                    = "spot"
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }

  node_taints = [
    "spot:NoSchedule",
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  ]

  tags = var.tags
}