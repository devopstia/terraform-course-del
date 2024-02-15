variable "vpc_prefix" {
  type    = string
  default = "/2560/adl/vpc"
}

variable "common_tags" {
  type = map(any)
  default = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "AssetAreaName" = "ADL"
    "ControlledBy"  = "Terraform"
    "cloudProvider" = "aws"
  }
}
