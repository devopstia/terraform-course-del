variable "aws_region_main" {
  type    = string
  default = "us-east-1"
}

variable "aws_region_backup" {
  type    = string
  default = "us-east-2"
}

variable "env_type" {
  type    = string
  default = "development"
}

variable "project_name" {
  type    = string
  default = "alpha"
}

variable "common_tags" {
  type = map(any)
  default = {
    "AssetID"       = "6258",
    "AssetName"     = "ALPHA",
    "AssetAreaName" = "Terraform",
    "ControlledBy"  = "Terraform"
  }
}
