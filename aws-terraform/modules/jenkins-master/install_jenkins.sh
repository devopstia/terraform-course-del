#!/bin/bash

# https://www.jenkins.io/doc/book/installing/linux/#debianubuntu
# Please install the Long Term Support release

function jenkins_installation {
    sudo apt update
    ## Set vim as default text editor
    sudo update-alternatives --set editor /usr/bin/vim.basic
    sudo update-alternatives --set vi /usr/bin/vim.basic
    sudo apt install fontconfig openjdk-17-jre -y
    java -version

    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y

    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    INSTANCE_PUBLIC_IP=$(curl -s ifconfig.me)
    ADMIN_KEY=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
    JENKINS_URL="http://$INSTANCE_PUBLIC_IP:8080"
    echo "Jenkins is installed and running. You can access it at $JENKINS_URL"
    echo "This is the initialAdminPassword: $ADMIN_KEY"
}

jenkins_installation