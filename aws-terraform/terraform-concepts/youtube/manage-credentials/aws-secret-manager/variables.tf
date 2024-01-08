variable "aws_region" {
  type = string
}

variable "aws-secret-string" {
  type = list(string)
  default = [
    "mysql-db-password",
    "postges-aurora-db-password",
    "postgres-db",
    "mysql-aurora-db-password"
  ]
}

variable "tags" {
  type = map(string)
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}
