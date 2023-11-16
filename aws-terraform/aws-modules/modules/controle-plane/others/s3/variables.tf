variable "common_tags" {
  type = map(any)
  default = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "Teams"         = "DEL"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}

variable "eks_version" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}
