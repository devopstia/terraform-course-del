resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = format("%s-%s-%s-aks", var.tags["id"], var.tags["environment"], var.tags["project"])
  location            = format("%s", var.tags["location"])
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = format("%s-%s-%s-dns-prefix", var.tags["id"], var.tags["environment"], var.tags["project"])
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version

  sku_tier                = "Free" # For production change to "Standard" 
  private_cluster_enabled = false
  # public_network_access_enabled = true
  automatic_channel_upgrade = "stable"

  default_node_pool {
    name                 = "systempool"
    vm_size              = "Standard_DS2_v2"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    zones                = [1, 2, 3]
    vnet_subnet_id       = data.azurerm_subnet.existing_subnet.id
    enable_auto_scaling  = true

    max_count       = 3
    min_count       = 1
    os_disk_size_gb = 30

    type = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
      "environment"   = "dev"
      "nodepoolos"    = "linux"
      "app"           = "system-apps"
    }
    tags = var.tags
  }

  # # Identity (System Assigned or Service Principal)
  # identity {
  #   type = "SystemAssigned"
  # }

  # # Identity (System Assigned or Service Principal)
  service_principal {
    client_id     = data.azurerm_key_vault_secret.application_id.value
    client_secret = data.azurerm_key_vault_secret.client_secret.value
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
    # enabled                    = true
  }

  # Windows Profile
  windows_profile {
    admin_username = var.windows_admin_username
    admin_password = data.azurerm_key_vault_secret.windows_admin_password.value
  }

  # Linux Profile
  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file("${path.module}/vm-ssh-key/azure-terraform.pub")
    }
  }

  # Network Profile
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = var.tags
}


# resource "azurerm_kubernetes_cluster_node_pool" "second_node_pool" {
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
#   name                  = "secondpool"
#   vm_size               = "Standard_DS2_v2"
#   vnet_subnet_id        = data.azurerm_subnet.existing_subnet.id
#   orchestrator_version  = data.azurerm_kubernetes_service_versions.current.latest_version
#   enable_auto_scaling   = true
#   max_count             = 3
#   min_count             = 1
#   os_disk_size_gb       = 30
#   mode                  = "User"
#   priority              = "Regular"
#   os_type               = "Linux"
#   node_labels = {
#     "nodepool-type" = "second"
#     "environment"   = "dev"
#     "nodepoolos"    = "linux"
#     "app"           = "second-apps"
#   }
#   tags = var.tags
# }