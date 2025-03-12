#!/bin/bash

# subnet 10.1.1.0/24
# ip 10.1.1.129
# gw 10.1.1.254
# dns 10.1.0.111
# dns 10.1.0.112
# network IN100001
# Ubuntu Server Hardening Script

# Update the system
echo "Updating the system..."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install sshd

# Disable unnecessary services to improve security
#echo "Disabling unnecessary services..."
# sudo systemctl disable --now apache2
# sudo systemctl disable --now mysql
# sudo systemctl disable --now cups
# Add more services you want to disable

# Remove unnecessary packages
echo "Removing unnecessary packages..."
sudo apt-get purge -y apache2 mysql-server cups

# Install necessary security updates
echo "Installing necessary security updates..."
sudo apt-get install unattended-upgrades -y

# Enable automatic security updates
echo "Enabling automatic security updates..."
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Disable root login via SSH
echo "Disabling root login via SSH..."
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl reload ssh

# Set up a firewall (UFW) to allow only necessary ports
echo "Setting up UFW firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
# Add more allowed ports as needed
sudo ufw enable

# Install fail2ban to prevent brute-force attacks
echo "Installing fail2ban..."
sudo apt-get install fail2ban -y
sudo systemctl enable fail2ban --now

# Disable IPv6 if not required (optional)
echo "Disabling IPv6 (optional)..."
# sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
# sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
# sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

# Set strong password policies
echo "Setting strong password policies..."
echo "password requisite pam_pwquality.so retry=3 minlen=12 difok=3" | sudo tee -a /etc/pam.d/common-password

# Remove old kernels (optional)
echo "Removing old kernels..."
sudo apt-get autoremove --purge -y

# Clean up
echo "Cleaning up the system..."
sudo apt-get clean
sudo apt-get autoclean

echo "Hardening complete!"