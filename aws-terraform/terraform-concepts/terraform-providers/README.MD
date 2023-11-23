## Providers
```s
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 3.76.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.69.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source  = "datadog/datadog"
      version = "3.0.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 1.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "~> 1.0"
    }
  }
}
```