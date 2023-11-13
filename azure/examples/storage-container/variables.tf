variable "common_tags" {
  type = map(any)
  default = {
    environment    = "dev"
    project        = "alpha"
    created_by     = "Terraform"
    cloud_provider = "aws"
  }
}
