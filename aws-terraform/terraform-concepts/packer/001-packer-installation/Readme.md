## packer releases
https://releases.hashicorp.com/packer/


## Download links
https://developer.hashicorp.com/packer/downloads

## Mac
```
 brew tap hashicorp/tap
 brew install hashicorp/tap/packer
 ```

## Ubuntu
```
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install packer
```

## Centos RHEL
```
 sudo yum install -y yum-utils
 sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
 sudo yum -y install packer
 ```