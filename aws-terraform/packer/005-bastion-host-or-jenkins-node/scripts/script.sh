#!/bin/bash

# Use Canonical, Ubuntu, 20.04 LTS, amd64 focal image build on 2023-10-25 to avoid and prompt

# ubuntu = Ubuntu
# redhat = Red Hat Enterprise Linux
# centos = CentOS Linux
# amazon-ec2 = Amazon Linux

OS_NAME=$(cat /etc/*release |grep -w NAME |awk -F'"' '{print$2}')
UBUNTU_VERSION=$(cat /etc/*release |grep DISTRIB_RELEASE |awk -F"=" '{print$2}' |awk -F"." '{print$1}')

function yum_os {
  echo "This is $OS_NAME OS. Please wait ----------------------------------------------"
  sleep 5
  echo "This can only run on Ubuntu for now. We have not yet written the code for Red Hat Enterprise Linux, CentOS Linux and Amazon Linux"
  exit
}

function apt_os {
    echo "This is $OS_NAME 20 OS. Please wait ----------------------------------------------"
    sleep 5
    # List of packages to install
    packages=(
        curl 
        wget 
        vim 
        git 
        make 
        ansible 
        python3-pip 
        openssl 
        rsync 
        jq 
        postgresql-client 
        mariadb-client 
        mysql-client-8.0
        mysql-client 
        unzip 
        tree 
        openjdk-11-jdk
        default-jre 
        default-jdk 
        fontconfig openjdk-17-jre
        maven
        nodejs npm
    )
    # Update package
    sudo apt update -y
    sudo apt upgrade -y

    # Install packages
    for package in "${packages[@]}"; do
        echo "Installing $package Please wait ................."
        sleep 3
        sudo apt install -y "$package"
    done
    echo "Package installation completed."
}

function apt_software {
    ## Install aws cli
    which aws
    if [ "$?" -eq 0 ]; then
        echo "AWS ClI is intalled already. Noting to do"
    else
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        rm -rf awscliv2.zip
        rm -rf aws
    fi

    ## Terraform version 1.0.0
    ## https://releases.hashicorp.com/terraform/
    TERRAFORM_VERSION="1.0.0"
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    mv terraform /usr/local/bin/
    terraform --version
    rm -rf terraform_${TERRAFORM_VERSION}_linux_amd64.zip

    ## Install grype
    ## https://github.com/anchore/grype/releases
    GRYPE_VERSION="0.66.0"
    wget https://github.com/anchore/grype/releases/download/v${GRYPE_VERSION}/grype_${GRYPE_VERSION}_linux_amd64.tar.gz
    tar -xzf grype_${GRYPE_VERSION}_linux_amd64.tar.gz
    chmod +x grype
    sudo mv grype /usr/local/bin/
    grype version

    ## Install Gradle
    ## https://gradle.org/releases/
    GRADLE_VERSION="4.10"
    sudo apt install openjdk-11-jdk -y
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
    unzip gradle-${GRADLE_VERSION}-bin.zip
    mv gradle-${GRADLE_VERSION} /opt/gradle-${GRADLE_VERSION}
    /opt/gradle-${GRADLE_VERSION}/bin/gradle --version

    ## Install kubectl
    sudo curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl 
    sudo chmod +x ./kubectl 
    sudo mv kubectl /usr/local/bin/

    ## INSTALL KUBECTX AND KUBENS
    sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx 
    sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens 
    sudo chmod +x kubectx kubens 
    sudo mv kubens kubectx /usr/local/bin

    ## Install Helm 3
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    sudo  chmod 700 get_helm.sh
    sudo ./get_helm.sh
    sudo helm version

    ## Install Docker Coompose
    # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version

    ### TERRAGRUNT INSTALLATIN
    # https://terragrunt.gruntwork.io/docs/getting-started/supported-terraform-versions/
    TERRAGRUNT_VERSION="v0.38.0"
    sudo wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 
    sudo mv terragrunt_linux_amd64 terragrunt 
    sudo chmod u+x terragrunt 
    sudo mv terragrunt /usr/local/bin/terragrunt
    terragrunt --version

    ## Install Packer
    # https://developer.hashicorp.com/packer/downloads
    sudo wget https://releases.hashicorp.com/packer/1.7.4/packer_1.7.4_linux_amd64.zip -P /tmp
    sudo unzip /tmp/packer_1.7.4_linux_amd64.zip -d /usr/local/bin
    chmod +x /usr/local/bin/packer
    packer --version

    ## Install trivy
    sudo apt-get -y update
    sudo apt-get install wget apt-transport-https -y
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
    echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
    sudo apt-get -y update
    sudo apt-get install trivy -y

    ## Install ArgoCD agent
    wget https://github.com/argoproj/argo-cd/releases/download/v2.8.5/argocd-linux-amd64
    chmod +x argocd-linux-amd64
    sudo mv argocd-linux-amd64 /usr/local/bin/argocd

    ## Install Docker
    # https://docs.docker.com/engine/install/ubuntu/
    sudo apt-get remove docker docker-engine docker.io containerd runc -y
    sudo apt-get update
    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    sudo apt-get update
    sudo apt install docker-ce docker-ce-cli containerd.io -y
    sudo systemctl start docker
    sudo systemctl enable docker

    ## chmod the Docker socket. the Docker daemon does not have the necessary permissions to access the Docker socket file located at /var/run/docker.sock
    sudo chown root:docker /var/run/docker.sock
    sudo chmod 666 /var/run/docker.sock

    # Install sonar-scanner CLI
    # https://github.com/SonarSource/sonar-scanner-cli/releases
    sonar_scanner_version="5.0.1.3006"                 
    wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${sonar_scanner_version}-linux.zip
    unzip sonar-scanner-cli-${sonar_scanner_version}-linux.zip
    sudo mv sonar-scanner-${sonar_scanner_version}-linux sonar-scanner
    sudo rm -rf  /var/opt/sonar-scanner || true
    sudo mv sonar-scanner /var/opt/
    sudo rm -rf /usr/local/bin/sonar-scanner || true
    sudo ln -s /var/opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/ || true
    sonar-scanner -v
}

function user_setup {
cat << EOF > /usr/users.txt
jenkins
ansible 
automation
EOF
    username=$(cat /usr/users.txt | tr '[A-Z]' '[a-z]')
    GROUP_NAME="tools"

    # cat /etc/group |grep -w tools &>/dev/nul || sudo groupadd $GROUP_NAME

    if grep -q "^$GROUP_NAME:" /etc/group; then
        echo "Group '$GROUP_NAME' already exists."
    else
        sudo groupadd "$GROUP_NAME"
        echo "Group '$GROUP_NAME' created."
    fi

    if sudo grep -q "^%$GROUP_NAME" /etc/sudoers; then
        echo "Group '$GROUP_NAME' is already in sudoers."
    else
        echo "%$GROUP_NAME ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
        echo "Group '$GROUP_NAME' added to sudoers with NOPASSWD: ALL."
    fi

    ## allow automation tools to access docker
    for i in $username
    do 
        if grep -q "^$i" /etc/sudoers; then
            echo "User '$i' is already in sudoers."
        else
            echo "$i ALL=(ALL) NOPASSWD: /usr/bin/docker" | sudo tee -a /etc/sudoers
        fi
    done

    for users in $username
    do
        ls /home |grep -w $users &>/dev/nul || mkdir -p /home/$users
        cat /etc/passwd |awk -F: '{print$1}' |grep -w $users &>/dev/nul ||  useradd $users
        chown -R $users:$users /home/$users
        usermod -s /bin/bash -aG tools $users
        usermod -s /bin/bash -aG docker $users
        echo -e "$users\n$users" |passwd "$users"
    done

    ## Set vim as default text editor
    sudo update-alternatives --set editor /usr/bin/vim.basic
    sudo update-alternatives --set vi /usr/bin/vim.basic
}

function enable_password_authentication {
    # Check if password authentication is already enabled
    if grep -q "PasswordAuthentication yes" /etc/ssh/sshd_config; then
        echo "Password authentication is already enabled."
    else
        # Enable password authentication by modifying the SSH configuration file
        sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
        echo "Password authentication has been enabled in /etc/ssh/sshd_config."

        # Restart the SSH service to apply changes
        sudo systemctl restart ssh
        echo "SSH service has been restarted."
    fi
}

function ssh_key {
    sudo su - jenkins 
    ssh-keygen -t rsa -f /home/jenkins/.ssh/id_rsa -N "" || true
    echo
    # echo 'Below is ssh private key that you need in jenkins for ssh repo checkout -------------------------------' 
    # cat /home/$USER/.ssh/id_rsa
    # echo
    # echo
    # echo 'Below is ssh public key that you need in jenkins for ssh repo checkout --------------------------------' 
    # cat /home/$USER/.ssh/id_rsa.pub
}


if [[ $OS_NAME == "Red Hat Enterprise Linux" ]] || [[ $OS_NAME == "CentOS Linux" ]] || [[ $OS_NAME == "Amazon Linux" ]] 
then
    yum_os
elif [[ $OS_NAME == "Ubuntu" ]]  && [ $UBUNTU_VERSION -le "20" ]
then
    apt_os
    apt_software
    user_setup
    enable_password_authentication
    ssh_key
else
    echo "It looks like the Ubuntu version that you installed in greater than version 20. Please install Ubuntu 20 to run this script to avoid Kernel update popup windows during the script execution."
    exit
fi