#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl enable apache2
systemctl start apache2

apt update
apt install vim -y
apt install unzip -y
apt install wget -y

cd /var/www/html
rm -rf index.html
wget https://warfiles-for-docker.s3.amazonaws.com/app/creative.zip
unzip creative.zip
rm -rf creative.zip

wget https://warfiles-for-docker.s3.amazonaws.com/app/restaurant.zip
unzip restaurant.zip
rm -rf restaurant.zip
cp -r restaurant/* .

wget https://warfiles-for-docker.s3.amazonaws.com/app/articles.zip
unzip articles.zip
rm -rf articles.zip

