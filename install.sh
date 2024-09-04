#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install Make
echo "Installing make..."
sudo apt-get install -y make

# Install UFW and open required ports
echo "Installing ufw and setting up firewall rules..."
sudo apt-get install -y ufw
sudo ufw allow 443/tcp
sudo ufw allow 9000/tcp
sudo ufw allow 3306/tcp
sudo ufw --force enable

# Install Docker
echo "Installing Docker..."
if ! command_exists docker; then
    sudo apt-get install -y http://docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "Docker is already installed"
fi

# Install Docker CLI
echo "Installing Docker CLI..."
sudo apt-get install -y docker-ce-cli

# Install Docker Compose
echo "Installing Docker Compose..."
if ! command_exists docker-compose; then
    sudo apt-get install -y docker-compose
else
    echo "Docker Compose is already installed"
fi

# Add the current user to the Docker group
echo "Adding the current user to the docker group..."
sudo usermod -aG docker $USER

# Install VSCode
echo "Installing Visual Studio Code..."
if ! command_exists code; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get update
    sudo apt-get install -y code
    rm -f packages.microsoft.gpg
else
    echo "VSCode is already installed"
fi

# Install Vim
echo "Installing Vim..."
sudo apt-get install -y vim

# Modify /etc/hosts
HOST_ENTRY="127.0.0.1 $(whoami).http://42.fr"
if ! grep -q "$HOST_ENTRY" /etc/hosts; then
    echo "Adding $HOST_ENTRY to /etc/hosts"
    echo "$HOST_ENTRY" | sudo tee -a /etc/hosts > /dev/null
else
    echo "$HOST_ENTRY already exists in /etc/hosts"
fi

echo "All tasks completed successfully."

echo "Please log out and back in, or restart your system to apply the Docker group changes."
