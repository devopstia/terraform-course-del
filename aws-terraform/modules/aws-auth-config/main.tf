resource "null_resource" "cluster-auth-apply" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.control_plane_name} --region ${var.aws_region} --alias ${var.control_plane_name}"
  }
}
