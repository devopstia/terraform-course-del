control_plane_name = "2560-dev-del"
aws_region         = "us-east-1"
name_spaces = [
  "aws-ebs-csi-driver",
  "aws-efs-csi-driver",
  "cluster-autoscaler",
  "external-dns",
  "metrics-server",
  "app",
  "datadog",
  "monitoring",
  "argocd",
  "security",
  "jenkins",
]

tags = {
  "id"             = "2560"
  "owner"          = "DevOps Easy Learning"
  "teams"          = "DEL"
  "environment"    = "dev"
  "project"        = "del"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}
