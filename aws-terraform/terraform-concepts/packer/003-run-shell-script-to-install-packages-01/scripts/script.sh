echo Installing Updates
sudo apt -y update
sudo apt install -y vim
sudo apt install -y wget
sudo apt install -y unzip
sudo apt install apache2 -y
sudo systemctl status apache2
sudo systemctl enable apache2