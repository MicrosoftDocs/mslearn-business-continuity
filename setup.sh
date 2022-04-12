!/bin/bash
echo "Creating VM..." az vm create --name labvm --image UbuntuLTS --admin-username azureuser --generate-ssh-keys --resource-group demo

printf "*********************** Lab Environment Created *********************\n\n"
