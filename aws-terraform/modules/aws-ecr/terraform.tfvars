aws_region = "us-east-1"
ecr_repository_names = [
  "db",
  "redis",
  "ui",
  "auth",
  "weather"
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
