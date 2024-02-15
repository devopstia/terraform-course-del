variable "control_plane_name" {
  type    = string
  default = "eks"
}

variable "namespace" {
  type    = string
  default = "kube-system"
}


# # variable "eks_oidc_root_ca_thumbprint" {
# #   type        = string
# #   description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
# #   default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
# # }


# # EKS OIDC ROOT CA Thumbprint - valid until 2037
# # https://github.com/hashicorp/terraform-provider-aws/issues/10104
# variable "oidc_thumbprint" {
#   type    = string
#   default = "9E99A48A9960B14926BB7F3B02E22DA2B0AB7280"
# }

# variable "param_store_prefix_vpc" {
#   type    = string
#   default = "/2560/adl/vpc"
# }

# variable "param_store_prefix_eks" {
#   type    = string
#   default = "/2560/adl/eks"
# }


# variable "common_tags" {
#   type = map(any)
#   default = {
#     "AssetID"       = "2560"
#     "AssetName"     = "Insfrastructure"
#     "AssetAreaName" = "ADL"
#     "ControlledBy"  = "Terraform"
#     "cloudProvider" = "aws"
#   }
# }
