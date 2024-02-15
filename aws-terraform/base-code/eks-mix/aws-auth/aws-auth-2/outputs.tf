output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = data.aws_eks_cluster.example.id
}

output "cluster_certificate_authority_data" {
  description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
  value       = data.aws_eks_cluster.example.certificate_authority[0].data
}

output "cluster_api_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = data.aws_eks_cluster.example.endpoint
}

# output "cluster_id" {
#   description = "The name/id of the EKS cluster."
#   value       = data.aws_eks_cluster.example.id
# }
