#!/bin/bash
resource=`az group list --query '[0].name' --output tsv`

echo "Creating VM..."
az vm create --name labvm --image UbuntuLTS --admin-username azureuser --generate-ssh-keys --resource-group $resource

printf "***********************  Lab Environment Created  *********************\n\n"
