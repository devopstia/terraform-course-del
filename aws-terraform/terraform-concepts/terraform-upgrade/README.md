## Check Terraform version in the state file
```
terraform state pull |grep terraform_version
```

## Upgrading to Terraform v1.0
- https://www.terraform.io/language/upgrade-guides/1-0


## hashicorp/terraform
- https://github.com/hashicorp/terraform/releases
- https://releases.hashicorp.com/terraform/

## CHANGELOG.md 0.14
- https://github.com/hashicorp/terraform/blob/v0.14/CHANGELOG.md
- Terraform v1.0 is an unusual release in that its primary focus is on stability, and it represents the culmination of several years of work in previous major releases to make sure that the Terraform language and internal architecture will be a suitable foundation for forthcoming additions that will remain `backward-compatible`.
- Terraform v1.0.0 intentionally has no significant changes compared to Terraform v0.15.5. You can consider the v1.0 series as a direct continuation of the v0.15 series.
- There are no special steps to take if you are upgrading from the previous major release, Terraform v0.15.
- You can also upgrade directly from Terraform v0.14 if you wish
- Upgrade directly to the latest Terraform v1.0 release and attempt a normal Terraform run. Terraform v1.0 is a continuation of the v0.15 series, and so v1.0.0 and later are directly backward-compatible with Terraform v0.15.5.

## Upgrading terraform configuration from 0.12.30 to 1.0(latest)
- https://discuss.hashicorp.com/t/upgrading-terraform-configuration-from-0-12-30-to-1-0-latest/27997
- We are planning to upgrade our terraform configuration from version 0.12.30 to the latest version 1.0. few questions that are in my mind that i want to confirm.
- Can we directly upgrade from 0.12.30 to 1.0 or do we need to go to 0.13 first?
- What is recommended approach for terraform configuration upgrade?
- Please suggest to me the best practice for an upgrade.
- yes, you have to upgrade first to 0.13.X, because there have been some changes in the format of the backend. Then the recommended path is to also upgrade to 0.14.X, and Hashicorp says that it could be possible to upgrade to 1.0.X.
- Terraform support backward compatibility starting from 1.0.X.


## Install terraform on Mac
https://stackoverflow.com/questions/69902998/terraformmacoszsh-exec-format-error-terraform

Please download terraform_1.0.10_darwin_amd64.zip for MAC

```sh
wget https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_darwin_amd64.zip
unzip terraform_0.13.0_darwin_amd64.zip
mv terraform tf13
sudo cp ~/Downloads/tf13 /usr/local/bin
tf13 --version
```

```sh
wget https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_darwin_amd64.zip
unzip terraform_0.14.0_darwin_amd64.zip
mv terraform tf14
sudo cp ~/Downloads/tf14 /usr/local/bin
tf14 --version
```

```sh
wget https://releases.hashicorp.com/terraform/1.2.6/terraform_1.2.6_darwin_amd64.zip
unzip terraform_1.2.6_darwin_amd64.zip
cd ~/Downloads
sudo mv terraform /usr/local/bin
terraform --version

OR

wget https://releases.hashicorp.com/terraform/1.2.6/terraform_1.2.6_darwin_amd64.zip
unzip terraform_1.2.6_darwin_amd64.zip
cd ~/Downloads
mv terraform terraform1 
sudo mv terraform1 /usr/local/bin
terraform1 --version
```

```
tf1 state pull |grep terraform_version
```