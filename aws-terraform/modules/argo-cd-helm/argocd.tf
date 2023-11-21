resource "null_resource" "argo_cd_upgrade" {
  provisioner "local-exec" {
    command = <<-EOT
      aws eks update-kubeconfig --name ${var.control_plane_name} --region ${var.aws_region} --alias ${var.control_plane_name}
      helm repo add argo https://argoproj.github.io/argo-helm
      helm repo update
      helm upgrade argo-cd --install ../../helm/charts/argo-cd --values argo-cd.yaml --namespace argo-cd
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
