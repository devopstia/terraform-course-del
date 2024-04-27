# resource "null_resource" "cluster-auth-apply" {
#   triggers = {
#     always_run = timestamp()
#   }
#   provisioner "local-exec" {
#     command = "az aks get-credentials --resource-group ${var.aks_rg} --name ${var.aks_control_plane_name}"
#   }
# }


resource "null_resource" "cluster-auth-apply" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = <<-EOT
      az account set --subscription "${var.subscription_id}"
      az aks get-credentials --resource-group ${var.aks_rg} --name ${var.aks_control_plane_name}
    EOT
  }
}

