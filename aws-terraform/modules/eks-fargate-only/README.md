## Fargate
- Fargate profile are same namespace in kubernetes
- Fargate can only be deploy in private subnets and not public
- Make sure to create a fargate profile for a specific app as namespace before deploying it

## How to patch the coredns so that it can be deploy on fargate nodes?
- When we deploy and EKS control plane, coredns pods are in pending stage
- We need to run the below command to patch the coredns so that it can be sheduled on fargate nodes
```sh
kubectl patch deployment coredns \
-n kube-system \
--type json \
-p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
```

## We can also the below null resource
```s
resource "null_resource" "coredns-patch" {
  depends_on = [aws_eks_fargate_profile.kube-system]
  provisioner "local-exec" {
    command = "kubectl patch deployment coredns -n kube-system --type json -p='[{'op': 'remove', 'path': '/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type'}]'"
  }
}
```