
## kubernetes_namespace

https://www.terraform.io/language/meta-arguments/for_each
https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace

```sh
resource "kubernetes_namespace" "k8s_namespace" {
  for_each = toset([
    "monitoring",
    "jenkins",
    "sonarqube",
    "grafana",
    "dev1",
    "dev2",
    "prod",
    "stage",
    "qa1",
    "qa2"
  ])
  metadata {
    name = each.key
  }
}
```

## Data Source: aws_eks_cluster_auth
```sh
data "aws_eks_cluster" "example" {
  name = "example"
}

data "aws_eks_cluster_auth" "example" {
  name = "example"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.example.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.example.token
  load_config_file       = false
}
```

## Data Source: aws_eks_cluster
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster

```sh
data "aws_eks_cluster" "example" {
  name = "demo-cluster"
}

output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = data.aws_eks_cluster.example.id
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = data.aws_eks_cluster.example.arn
}

output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = data.aws_eks_cluster.example.certificate_authority[0].data
}

output "cluster_api_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = data.aws_eks_cluster.example.endpoint
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = data.aws_eks_cluster.example.version
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = data.aws_eks_cluster.example.identity[0].oidc[0].issuer
}

output "cluster_primary_security_group_id" {
  description = "The cluster primary security group ID created by the EKS cluster on 1.14 or later. Referred to as 'Cluster security group' in the EKS console."
  value       = data.aws_eks_cluster.example.vpc_config[0].cluster_security_group_id
}
```

