#!/bin/bash
set -e

# Log output
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt-get install unzip
unzip awscliv2.zip
sudo ./aws/install

# Update and install Java
echo "Updating packages and installing Java..."
sudo apt-get update -y
sudo apt-get install -y fontconfig openjdk-17-jre

# Verify Java installation
java -version

# Add Jenkins repository and key
echo "Adding Jenkins repository and key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update and install Jenkins
echo "Updating package lists and installing Jenkins..."
sudo apt-get update -y
sudo apt-get install -y jenkins

# Start and enable Jenkins service
echo "Starting and enabling Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Confirm Jenkins is running
if systemctl status jenkins | grep -q "active (running)"; then
    echo "Jenkins installation and setup completed successfully."
else
    echo "Jenkins failed to start. Check logs for details."
    exit 1
fi

sleep 60

# Download CLI
wget -O http://localhost:8080/jnlpJars/jenkins-cli.jar

# Reset password
java -jar jenkins-cli.jar -s http://localhost:8080 groovy = <<EOF
import jenkins.model.*
def instance = Jenkins.getInstance()
def adminUser = instance.getSecurityRealm().createAccount('admin', 'NewPassword123')
adminUser.save()
EOF
