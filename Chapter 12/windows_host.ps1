# Connect to your Azure VM
az login

# List your VM disks
# IMPORTANT!!! Use your Big Data Cluster resource group name
az disk list --resource-group bdcrg --query '[*].{Name:name,Gb:diskSizeGb,Tier:accountType}' --output table

# Deallocate the VM
az vm deallocate --resource-group bdcrg --name myvm

# Resize VM disk
# IMPORTANT!!! Use your Big Data Cluster resource group name, and the disk name returned in a previous command
az disk update --resource-group bdcrg --name myvm_OsDisk_1_c7e3b4ab74ee4aa89f6fbfae5538a131 --size-gb 200

# Start the VM
# IMPORTANT!!! Use your Big Data Cluster resource group name
az vm start --resource-group bdcrg --name myvm

# Login remotely to your VM using password
# IMPORTANT!!! Use your Big Data Cluster username and public IP address
ssh pabechevb@40.85.153.169

# Login to Big Data Cluster created from Azure Data Studio and view the instance details
# IMPORTANT!!! Use your Big Data Cluster name
azdata login -n mssql-cluster
kubectl get pods -n mssql-cluster
kubectl get all -n mssql-cluster
