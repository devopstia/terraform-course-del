aws_region              = "us-east-1"
control_plane_version   = "1.24"
endpoint_private_access = false
endpoint_public_access  = true

common_tags = {
  "AssetID"       = "2526"
  "AssetName"     = "Insfrastructure"
  "Teams"         = "DEL"
  "Environment"   = "dev"
  "Project"       = "alpha"
  "CreateBy"      = "Terraform"
  "cloudProvider" = "aws"
}
