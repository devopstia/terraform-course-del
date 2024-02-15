resource "null_resource" "apply-configmap" {
  provisioner "local-exec" {
    command = "kubectl apply -f eks-configmap-auth.yaml"
  }
  triggers = {
    always_run = timestamp()
  }
}

# triggers - A map of values which should cause this set of provisioners to re-run.
