## Multiple providers
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
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_s3" {
  bucket = "terraform-bucket-232"
}
```

## Arguments for Specifying the provider
There are multiple ways of specifying the version of a provider.
- >=1.0: Download plugins that are greater than or equal to one
- <=1.0: Download plugins that are less than or equal to one
- ~>2.0: Download plugins in the 2.X range. 
- Example: use the full version number: ~> 1.0.4 will allow installation of 1.0.5 and 1.0.10 but not 1.1.0. This is usually called the pessimistic constraint operator.
- >=2.10,<=2.30: Download any plugins version between 2.10 and 2.30

## Play with Terraform CLI Version (We installed 1.0.0 version)
- required_version = "~> 0.14.3" - Will fail (we can only have [0.14.0-0.14.9])
- required_version = "~> 0.14"   - Will fail  
- required_version = "= 0.14.4"  - Will fail
- required_version = ">= 0.13"   - will pass
- required_version = "= 1.0.0"   - will pass
- required_version = "1.0.0"     - will pass 
- required_version = ">= 1.0.0"   - will pass   
- required_version = "> 1.0.0"   - will fail ls

