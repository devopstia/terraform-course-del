## Terraform Releases
- https://releases.hashicorp.com/terraform/
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

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

## Download Links
```
https://releases.hashicorp.com/terraform/0.12.30/terraform_0.12.30_darwin_amd64.zip

https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_darwin_amd64.zip

https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_darwin_amd64.zip

https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_darwin_amd64.zip

https://releases.hashicorp.com/terraform/1.2.6/terraform_1.2.6_darwin_amd64.zip
```