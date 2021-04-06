# Update VM existing packages
sudo apt update&&sudo apt upgrade -y

# Restart VM
sudo systemctl reboot

# Download Microsoft script for cluster deployment
curl --output setup-bdc.sh https://raw.githubusercontent.com/microsoft/sql-server-samples/master/samples/features/sql-big-data-cluster/deployment/kubeadm/ubuntu-single-node-vm/setup-bdc.sh

# Make the script executable
chmod +x setup-bdc.sh

# Run the script with privileges
sudo ./setup-bdc.sh
