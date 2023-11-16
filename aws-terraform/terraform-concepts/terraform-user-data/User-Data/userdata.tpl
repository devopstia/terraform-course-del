#! /bin/bash 
# user data
sudo yum update -y
sudo yum install -y httpd
sudo systemctl restart httpd.service
sudo systemctl enable httpd.service
      
cd /var/www/html/
 
# liyeplimal website
sudo wget https://linux-devops-course.s3.amazonaws.com/WEB+SIDE+HTML/www.liyeplimal.net.zip
sudo unzip www.liyeplimal.net.zip
sudo rm -rf www.liyeplimal.net.zip
sudo cp -R www.liyeplimal.net/* .
sudo rm -rf www.liyeplimal.net