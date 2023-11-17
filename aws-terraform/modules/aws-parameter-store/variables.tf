variable "aws_region" {
  type = string
}

variable "aws-param-values" {
  type = list(string)
  default = [
    "mysql-db",
    "postges-aurora",
    "postgres-db",
    "mysql-aurora-db"
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
