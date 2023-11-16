## Local Reference
```s
module "acm" {
  aws_region                = local.aws_region
  domain_name               = local.domain_name
  subject_alternative_names = local.subject_alternative_names
  tags                      = local.tags
}
```

## SSH Local Reference From Github
- You must use ssh key to authentication if it is a private repository
```s
module "acm" {
  source                  = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/acm?ref=main"
  aws_region                = local.aws_region
  domain_name               = local.domain_name
  subject_alternative_names = local.subject_alternative_names
  tags                      = local.tags
}
```


## HTTPS Local Reference From Github
- You must use token to authentication if it is a private repository
```s
module "acm" {
  source                  = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=main"
  aws_region                = local.aws_region
  domain_name               = local.domain_name
  subject_alternative_names = local.subject_alternative_names
  tags                      = local.tags
}
```