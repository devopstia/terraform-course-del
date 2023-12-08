packer {
  required_version = ">= 1.8.5"
  required_plugins {
    amazon = {
      version = "1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    # azure = {
    #   version = "1.4.0"
    #   source  = "github.com/hashicorp/azure"
    # }
    # docker = {
    #   version = "1.0.8"
    #   source  = "github.com/hashicorp/docker"
    # }
  }
}