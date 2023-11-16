### Module Sources
* Generic Git Repository. For example, to use HTTPS or SSH:
```tf
module "vpc" {
  source = "git::https://example.com/vpc.git"
}

module "storage" {
  source = "git::ssh://username@example.com/storage.git"
}
```  

* Here we’re downloading the production branch of the module in the tf_vpc repository.
```tf
module "vpc" {
source = "git::https://github.com/turnbullpress/tf_vpc.git?ref=production"
}
```


* The value of the ref argument can be any reference that would be accepted by the git checkout command, including branch and tag names.
* By default, Terraform will clone and use the default branch (referenced by HEAD) in the selected repository. You can override this using the ref argument:
* v1.2.0 = tag in git

```tf 
module "vpc" {
  source = "git::https://example.com/vpc.git?ref=v1.2.0"
}
```

### Module Sources example
* ref=development: we are refer to the development branch
```tf
source = "./vpc"
source = "../../terraform/ec2/"
source = "github.com/leonardtia1/test-module/terraform/ec2"
source = "git::https://github.com/leonardtia1/test-module.git"
source = "git::https://github.com/leonardtia1/test-module.git?ref=development"
source = "git::ssh://github.com/leonardtia1/test-module.git"
```

### Tags
* Here we’re downloading the production branch of the module in the tf_vpc repository.
```tf
module "vpc" {
source = "git::https://github.com/turnbullpress/tf_vpc.git?ref=production"
}
```
* Committing and pushing our vpc module
```tf
$ pwd
~/terraform/web/vpc
$ git add .
$ git commit -m "First commit of VPC module"
$ git tag -a "v0.0.1" -m "First release of vpc module"
$ git remote add origin git@github.com:turnbullpress/tf_vpc.git
$ git push -u origin master --tags
```
* Updating our vpc module configuration
```tf
module "vpc" {
source = "github.com/turnbullpress/tf_vpc.git?ref=v0.0.1"
name = "web"
cidr = "10.0.0.0/16"
public_subnet = "10.0.1.0/24"
}
```

* We’ll need to get our module again since we’ve changed its source. Getting the new vpc module.
```tf
$ terraform get
Get: git::https://github.com/turnbullpress/tf_vpc.git?ref=v0.0.1
```

* Any time we want to use the vpc module, we can now just reference the module on GitHub. This also means we can manage multiple versions of the module—for example, we could create `v0.0.2` of the module, and then use the `ref` parameter to refer to that.
* This allows us to test a new version of a module without changing the old one.

```tf
$ pwd
~/terraform/web/vpc
$ git add .
$ git commit -m "First commit of VPC module"
$ git tag -a "v0.0.2" -m "Second release of vpc module"
$ git remote add origin git@github.com:turnbullpress/tf_vpc.git
$ git push -u origin master --tags
```

```tf
module "vpc" {
source = "github.com/turnbullpress/tf_vpc.git?ref=v0.0.2"
name = "web"
cidr = "10.0.0.0/16"
public_subnet = "10.0.1.0/24"
}
```

### Git Basics - Tagging
```
git tag -a v1.4 -m "my version 1.4"
git tag
git show v1.4
```