#!/bin/bash
apt-get update
apt-get install vim -y
apt-get install -y apache2

cat <<EOL > /var/www/html/index.html
<!DOCTYPE html>
<html>
<body>
<h1>Welcome to DevOps Easy Learning and Training</h1>
</body>
</html>
EOL

systemctl enable apache2
systemctl start apache2