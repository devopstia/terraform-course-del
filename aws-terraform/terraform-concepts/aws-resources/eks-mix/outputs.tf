
# # Remove https on OpenID Connect provider URL
# # https://oidc.eks.us-east-1.amazonaws.com/id/51C78AC6ADC42A55DE543DFE84A03DE6
# output "identity-oidc-url" {
#   value = split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]
# }

# output "aws_iam_openid_connect_provider_url" {
#   value = join("/", ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider", split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]])
# }



# # https://github.com/cloudposse/terraform-aws-eks-cluster/blob/master/outputs.tf

# # Cluster name
# output "cluster_id" {
#   description = "The name/id of the EKS cluster."
#   value       = aws_eks_cluster.demo.id
# }

# # Cluster certificate
# output "cluster_certificate_authority_data" {
#   description = "Nested attribute containing certificate-authority-data for your cluster. This is the base64 encoded certificate data required to communicate with your cluster."
#   value       = aws_eks_cluster.demo.certificate_authority[0].data
# }

# # Kubernetes API
# output "cluster_endpoint" {
#   description = "The endpoint for your EKS Kubernetes API."
#   value       = aws_eks_cluster.demo.endpoint
# }

# output "cluster_version" {
#   description = "The Kubernetes server version for the EKS cluster."
#   value       = aws_eks_cluster.demo.version
# }

# output "cluster_oidc_issuer_url" {
#   description = "The URL on the EKS cluster OIDC Issuer"
#   value       = aws_eks_cluster.demo.identity[0].oidc[0].issuer
# }


# output "eks_cluster_identity_oidc_issuer_arn" {
#   description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account"
#   value       = join("", aws_iam_openid_connect_provider.example.*.arn)
# }


