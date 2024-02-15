## AWS Fargate considerations
- https://docs.aws.amazon.com/eks/latest/userguide/fargate.html

Create AWS EKS Fargate Using Terraform (EFS, HPA, Ingress, ALB, IRSA, Kubernetes, Helm, Tutorial)
- https://antonputra.com/amazon/create-aws-eks-fargate-using-terraform/#create-aws-eks-fargate-using-terraform
- https://www.youtube.com/watch?v=acNFzmblj6U

## fargate cluster only
- if you want to run your workload in fargate only, you will need to deploy the EKS control plane and patch the coredns first.
- coredns run by default on EKS worker nodes
- When you create an EKS cluster without worker nodes, coredns pods will be pending in the `kube-system` namespace. 
- if you want coredns to be schedule on fargate node, you need to create a forgate profile with in `kube-system` namespsace and coredns will be shedule on fargate


```t
# AWS Fargate profile Role
resource "aws_iam_role" "eks-fargate-profile" {
  name = "eks-fargate-profile"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# AWS Fargate profile policy
resource "aws_iam_role_policy_attachment" "eks-fargate-profile" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks-fargate-profile.name
}

# AWS Fargate profile 
resource "aws_eks_fargate_profile" "kube-system" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "kube-system"
  pod_execution_role_arn = aws_iam_role.eks-fargate-profile.arn

  # These subnets must have the following resource tag: 
  # kubernetes.io/cluster/<CLUSTER_NAME>.
  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]

  selector {
    namespace = "kube-system"
  }
}
```

## coredns patch command
```sh 
kubectl patch deployment coredns \
-n kube-system \
--type json \
-p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
```

## Create Fargate Profile
```sh
# Get list of Fargate Profiles in a cluster
eksctl get fargateprofile --cluster eks

# Template
eksctl create fargateprofile --cluster <cluster_name> \
                             --name <fargate_profile_name> \
                             --namespace <kubernetes_namespace>


# Replace values
eksctl create fargateprofile --cluster eks \
                             --name kube-system \
                             --namespace kube-system
```

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: staging
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: php-apache
  namespace: staging
spec:
  selector:
    matchLabels:
      run: php-apache
  # remove replica if using gitops
  replicas: 1
  template:
    metadata:
      labels:
        run: php-apache
    spec:
      containers:
      - name: php-apache
        image: k8s.gcr.io/hpa-example
        ports:
        - containerPort: 80
        resources:
          limits:
            cpu: 200m
            memory: 256Mi
          requests:
            cpu: 200m
            memory: 256Mi
```