#! /bin/bash

apt-get update
apt-get install -y apache2
systemctl enable apache2
systemctl start apache2 
cd /var/www/html/index.html && rm -rf index.html
sudo echo '<h1>Welcome to DevOps Easy Learning!</h1>' | sudo tee /var/www/html/index.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>DevOps Easy Learning!</h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/index.html
