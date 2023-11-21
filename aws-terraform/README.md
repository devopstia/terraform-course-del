## Helm repository
- https://github.com/bitnami/charts/tree/main/bitnami
- https://github.com/kubernetes/autoscaler
- https://github.com/aws/eks-charts/tree/master/stable
- https://github.com/kubernetes-sigs/aws-ebs-csi-driver
- https://github.com/helm/charts/tree/master/stable

## Install terraform on Mac
https://stackoverflow.com/questions/69902998/terraformmacoszsh-exec-format-error-terraform
Please download terraform_1.0.10_darwin_amd64.zip for MAC

````
wget https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_darwin_amd64.zip
unzip terraform_0.13.0_darwin_amd64.zip
mv terraform tf13
sudo cp ~/Downloads/tf13 /usr/local/bin
tf13 --version

wget https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_darwin_amd64.zip
unzip terraform_0.14.0_darwin_amd64.zip
mv terraform tf14
sudo cp ~/Downloads/tf14 /usr/local/bin
tf14 --version

sudo cp ~/Downloads/terraform /usr/local/bin/tf1
cp ~/Downloads/terraform12 /usr/local/bin/tf12
https://releases.hashicorp.com/terraform/1.0.10/
https://releases.hashicorp.com/terraform/0.12.31/
```

