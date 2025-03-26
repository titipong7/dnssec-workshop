#!/bin/bash

######################
# subnet 10.1.1.0/24
# ip 10.1.1.129
# gw 10.1.1.254
# dns 10.1.0.111
# dns 10.1.0.112
# network IN100001
echo "Ubuntu Server: Installation Script"
# Step 1: Update system packages to ensure the latest security patches are installed
echo "Step 1: Updating the system..."
sudo apt-get update && sudo apt-get upgrade -y

# Step 2: Install necessary software
echo "Step 2: Install necessary software"
sudo apt-get install -y ssh ufw

# Step 3: Install necessary security updates
echo "Step 3:Installing necessary security updates..."
sudo apt-get install unattended-upgrades -y
sudo dpkg-reconfigure -f noninteractive unattended-upgrades

# Step 4: Set up a basic firewall (UFW)
echo "Step 4: Setting up a basic firewall..."
ufw allow OpenSSH   # Allow SSH connections
ufw enable           # Enable the firewall
ufw status           # Check the firewall status

# Step 5: Disable root login via SSH
echo "Step 5: Disabling root login via SSH..."
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl reload ssh

# Step 6: Enable automatic security updates
echo "Step 6: Enabling automatic security updates..."
echo "APT::Periodic::Update-Package-Lists "1";" > /etc/apt/apt.conf.d/10periodic
echo "APT::Periodic::Unattended-Upgrade "1";" >> /etc/apt/apt.conf.d/10periodic

### optional
# # Disable password authentication (use SSH keys instead)
# echo "Disabling password authentication for SSH..."
# sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# systemctl restart ssh

# # Set up strong password policy
# echo "Setting up password complexity rules..."
# apt install libpam-pwquality -y
# echo "password requisite pam_pwquality.so retry=3 minlen=12" >> /etc/pam.d/common-password

# Step 7: Disable IPv6 if not required (optional)
echo "Step 7: Disabling IPv6 (optional)..."
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

# Step 8: Remove old kernels (optional) && Cleaning up the system...
echo "Step 8: Removing old kernels..."
sudo apt-get autoremove --purge -y 
sudo apt-get clean

echo "Installation Script complete!"