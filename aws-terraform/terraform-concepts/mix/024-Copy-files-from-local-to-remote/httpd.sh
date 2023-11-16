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