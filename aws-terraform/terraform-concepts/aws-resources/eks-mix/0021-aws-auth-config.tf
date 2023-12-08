resource "null_resource" "cluster-auth-apply" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [aws_eks_cluster.eks]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.control_plane_name} --region us-east-1 --alias ${var.control_plane_name}"
  }
}
