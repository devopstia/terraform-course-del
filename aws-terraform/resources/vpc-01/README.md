## Local Reference
```s
module "vpc" {
  source             = "../../modules/vpc"
  cidr_block         = local.cidr_block
  region             = local.region
  availability_zones = local.availability_zones
  cluster_name       = local.cluster_name
  tags               = local.tags
}
```

## SSH Local Reference From Github
- You must use ssh key to authentication if it is a private repository
```s
module "vpc" {
  source             = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=main"
  cidr_block         = local.cidr_block
  region             = local.region
  availability_zones = local.availability_zones
  cluster_name       = local.cluster_name
  tags               = local.tags
}
```


## HTTPS Local Reference From Github
- You must use token to authentication if it is a private repository
```s
module "vpc" {
  source             = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=main"
  cidr_block         = local.cidr_block
  region             = local.region
  availability_zones = local.availability_zones
  cluster_name       = local.cluster_name
  tags               = local.tags
}
```


## Add tags
- add the below tags if you are using the default VPC so that the aws-load-balancer-controller can discover the subnets
- This should be perfect for all public subnet for default vpc: "kubernetes.io/role/elb" = 1

```s
public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }


kubernetes.io/cluster/2560-dev-dev = shared
kubernetes.io/role/elb = 1

kubernetes.io/cluster/2560-dev-dev = shared
kubernetes.io/role/internal-elb = 1
```


```s
tags = merge(var.tags, {
    Name                                        = format("%s-%s-%s-public-subnet-${count.index + 1}-${element(var.availability_zones, count.index)}", var.tags["id"], var.tags["environment"], var.tags["project"])
    "kubernetes.io/role/elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    },
  )

```s
tags = merge(var.tags, {
    Name                                        = format("%s-%s-%s-private-subnet-${count.index + 1}-${element(var.availability_zones, count.index)}", var.tags["id"], var.tags["environment"], var.tags["project"])
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    },
  )
```

```
kubernetes.io/role/internal-elb          = 1
kubernetes.io/cluster/2560-dev-del = shared
```

## cidrsubnet
```t
cidrsubnet("10.0.0.0/16", 8, 0)
cidrsubnet("10.0.0.0/16", 8, 1)
cidrsubnet("10.0.0.0/16", 8, 2)

cidrsubnet("10.0.0.0/16", 8, 3)
cidrsubnet("10.0.0.0/16", 8, 4)
cidrsubnet("10.0.0.0/16", 8, 5)


cidrsubnet("10.0.0.0/16", 8, 1)
cidrsubnet("10.0.0.0/16", 8, 2)
cidrsubnet("10.0.0.0/16", 8, 3)

cidrsubnet("10.0.0.0/16", 8, 4)
cidrsubnet("10.0.0.0/16", 8, 5)
cidrsubnet("10.0.0.0/16", 8, 6)


cidrsubnet("10.0.0.0/16", 6, 0)
cidrsubnet("10.0.0.0/16", 6, 1)
cidrsubnet("10.0.0.0/16", 6, 2)

cidrsubnet("10.0.0.0/16", 8, 3)
cidrsubnet("10.0.0.0/16", 8, 4)
cidrsubnet("10.0.0.0/16", 8, 5)
```