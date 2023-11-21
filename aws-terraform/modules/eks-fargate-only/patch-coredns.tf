resource "null_resource" "coredns-patch" {
  depends_on = [aws_eks_fargate_profile.kube-system]
  provisioner "local-exec" {
    command = "kubectl patch deployment coredns -n kube-system --type json -p='[{'op': 'remove', 'path': '/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type'}]'"
  }
}

# kubectl patch deployment coredns \
# -n kube-system \
# --type json \
# -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
