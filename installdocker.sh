#!/bin/bash

# https://docs.docker.com/engine/install/ubuntu/
# sudo apt-get remove docker docker-engine docker.io containerd runc

# Step 1: Update and Install Dependencies
echo "Step 1: Updating package list and installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release
echo "Dependencies installed successfully!"

# Step 2: Set up Docker's GPG Key and Repository
echo "Step 2: Setting up Docker's GPG key and repository..."
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Docker repository added successfully!"

# Step 3: Install Docker
echo "Step 3: Installing Docker..."
sudo apt update -y

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Docker installed successfully!"

# Step 4: Test Docker Installation
echo "Step 4: Running a test container (hello-world)..."
sudo docker run hello-world

echo "Docker installation verified successfully!"

# Step 5: Create a Custom Docker Network
echo "Step 5: Creating a custom Docker network..."
sudo docker network create --subnet=192.168.1.0/24 wsnet

echo "Custom Docker network created successfully!"

# Step 6: Post-Installation Configuration
echo "Step 6: Post-installation tasks..."
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
echo "User added to Docker group. Please log out and log back in for changes to take effect."

# https://docs.docker.com/engine/install/linux-postinstall/


# Step 7: Enable Docker Services
echo "Enable Docker services on startup?"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
echo "Docker services enabled successfully!"

#  sudo systemctl disable docker.service
#  sudo systemctl disable containerd.service

# Completion Message
echo "All tasks completed successfully!"