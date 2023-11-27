variable "context" {
  description = ""
  type        = any
  default = {
    eks_cluster_id  = "my-eks-cluster"
    cluster_version = "1.21"
    vpc_id          = "vpc-12345678"
    tags = {
      "id"             = "2560"
      "owner"          = "DevOps Easy Learning"
      "teams"          = "DEL"
      "environment"    = "dev"
      "project"        = "del"
      "create_by"      = "Terraform"
      "cloud_provider" = "aws"
    }
  }
}
variable "tags" {
  description = ""
  type        = map(string)
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


