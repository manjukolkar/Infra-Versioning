#!/bin/bash

yum update -y

# Install Git
yum install git -y

# Install Docker
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install Java (required for Jenkins)
yum install java-21 -y

# Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins

# Install Snap (for MicroK8s)
yum install snapd -y
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap

sleep 60

# Install MicroK8s
snap install microk8s --classic

usermod -aG docker jenkins
usermod -aG microk8s jenkins

# Wait for MicroK8s
microk8s status --wait-ready

# Enable addons
microk8s enable dns storage

echo "Setup Completed"
