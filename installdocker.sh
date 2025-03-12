#!/bin/bash

# https://docs.docker.com/engine/install/ubuntu/
# sudo apt-get remove docker docker-engine docker.io containerd runc

# Function to check for errors after each command
check_error() {
  if [ $? -ne 0 ]; then
    echo "Error in the previous step! Exiting script."
    exit 1
  fi
}

# Step 1: Update and Install Dependencies
echo "Step 1: Updating package list and installing dependencies..."
sudo apt-get update -y
check_error
sudo apt-get install -y ca-certificates curl gnupg lsb-release
check_error
echo "Dependencies installed successfully!"

# Step 2: Set up Docker's GPG Key and Repository
echo "Step 2: Setting up Docker's GPG key and repository..."
sudo mkdir -p /etc/apt/keyrings
check_error
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
check_error
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
check_error
echo "Docker repository added successfully!"

# Step 3: Install Docker
echo "Step 3: Installing Docker..."
sudo apt update -y
check_error
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
check_error
echo "Docker installed successfully!"

# Step 4: Test Docker Installation
echo "Step 4: Running a test container (hello-world)..."
sudo docker run hello-world
check_error
echo "Docker installation verified successfully!"

# Step 5: Create a Custom Docker Network
echo "Step 5: Creating a custom Docker network..."
sudo docker network create --subnet=192.168.1.0/24 wsnet
check_error
echo "Custom Docker network created successfully!"

# Step 6: Post-Installation Configuration
echo "Step 6: Post-installation tasks..."
#sudo groupadd docker
#sudo usermod -aG docker $USER
#check_error
#newgrp docker
#check_error
echo "User added to Docker group. Please log out and log back in for changes to take effect."

# https://docs.docker.com/engine/install/linux-postinstall/


# Step 7: Optional Enable/Disable Docker Services
echo "Would you like to enable Docker services on startup? (y/n)"
#read enable_services
#if [ "$enable_services" == "y" ]; then
  sudo systemctl enable docker.service
  sudo systemctl enable containerd.service
  echo "Docker services enabled successfully!"
#else
#  echo "Docker services will not start on boot."
#fi

#  sudo systemctl disable docker.service
#  sudo systemctl disable containerd.service


# Completion Message
echo "All tasks completed successfully!"