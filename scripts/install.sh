#!/bin/bash
set -e

apt update -y

# Install Git
apt install git -y

# Install Docker
apt install docker.io -y
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Install Java
apt update
apt install fontconfig openjdk-21-jre -y

# Install Jenkins
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

apt update -y
apt install jenkins -y
systemctl start jenkins
systemctl enable jenkins

# Install MicroK8s
snap install microk8s --classic

usermod -a -G microk8s ubuntu
usermod -a -G docker ubuntu

microk8s status --wait-ready
microk8s enable dns storage
