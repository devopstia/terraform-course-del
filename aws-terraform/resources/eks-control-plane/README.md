## Local Reference
```s
module "eks-control-plane" {
  source                  = "../../modules/eks-control-plane"
  region                  = local.region
  cluster_name            = local.cluster_name
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  public_subnets          = local.public_subnets
  tags                    = local.tags
}
```

## SSH Local Reference From Github
- You must use ssh key to authentication if it is a private repository
```s
module "eks-control-plane" {
  source                  = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/eks-control-plane?ref=main"
  region                  = local.region
  cluster_name            = local.cluster_name
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  public_subnets          = local.public_subnets
  tags                    = local.tags
}
```


## HTTPS Local Reference From Github
- You must use token to authentication if it is a private repository
```s
module "eks-control-plane" {
  source                  = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/eks-control-plane?ref=main"
  region                  = local.region
  cluster_name            = local.cluster_name
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  public_subnets          = local.public_subnets
  tags                    = local.tags
}
```