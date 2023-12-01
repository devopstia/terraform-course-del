## Terraform module
```s
# Refer module from AWS VPC module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
}

# Refer module from VPC module from local
module "vpc" {
  source = "../../modules/vpc/"
}

# Refer module from github using ssh connection and reference the branch main
module "vpc" {
  source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=main"
}

# Refer module from github using ssh connection and reference the branch develop
module "vpc" {
  source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=develop"
}

# Refer module from github using https connection and reference the branch main
module "vpc" {
  source = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=main"
}

# Refer module from github using https connection and reference the branch develop
module "vpc" {
  source = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=main"
}


# Refer module from github using ssh connection and reference the tag name v1.1.0
module "vpc" {
  source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=v1.1.0"

}

# Refer module from github using ssh connection and reference the tag name v1.1.0
module "vpc" {
  source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=v1.1.0"
}

# Refer module from github using https connection and reference the tag name v1.1.0
module "vpc" {
  source = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=v1.1.0"
}

# Refer module from github using https connection and reference the tag name v1.1.0
module "vpc" {
  source = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=v1.1.0"
}


# Refer module from github using ssh connection and reference the tag name 4a56c34
module "vpc" {
  source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=4a56c34"

}

# Refer module from github using ssh connection and reference the tag name 4a56c34
module "vpc" {
  source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=4a56c34"
}

# Refer module from github using https connection and reference the tag name 4a56c34
module "vpc" {
  source = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=4a56c34"
}

# Refer module from github using https connection and reference the tag name 4a56c34
module "vpc" {
  source = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=4a56c34"
}



```