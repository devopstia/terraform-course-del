* [How can I use Terraform's file provisioner to copy from my local machine onto a VM?](https://stackoverflow.com/questions/48567881/how-can-i-use-terraforms-file-provisioner-to-copy-from-my-local-machine-onto-a)

* NB: open port 80 on AWS default SG first

```sh
#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
cd /var/www/html

# liyeplimal website
wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/www.liyeplimal.net.zip
unzip www.liyeplimal.net.zip
rm -rf www.liyeplimal.net.zip
cp -R www.liyeplimal.net/* .
rm -rf www.liyeplimal.net
```