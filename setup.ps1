# SetupDemoBackup
# v1.0.1  2022-03-10

# Variables
[string] $vaultName = "VaultXp5";

[string] $vmName = "VM1";
[string] $vnetName = "VNet1";
[string] $subnetName = "Subnet1";
[string] $securityGroupName = "VM1-nsg";
[string] $publicIpAdName = "VM1-ip";

[string] $userName = "AdminXyz";
[string] $password = "sfr9jttzrjjeoem7hrf#";

[string] $imageName = "MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest";
[string] $size = "Standard_D2s_v3";


# Get resource group
# The subscription should contain just one empty resource group
$resourceGroup = (Get-AzResourceGroup)[0];

# Create recovery services vault
New-AzRecoveryServicesVault `
    -Name $vaultName `
    -Location $resourceGroup.Location `
    -ResourceGroupName $resourceGroup.ResourceGroupName;

Get-AzRecoveryServicesVault -Name $vaultName | `
    Set-AzRecoveryServicesBackupProperty -BackupStorageRedundancy LocallyRedundant;


# Create virtual machine
$pw = $password | ConvertTo-SecureString -Force -AsPlainText;
$credential = New-Object PSCredential($userName, $pw);

New-AzVm `
    -Name $vmName `
    -Location $resourceGroup.Location `
    -ResourceGroupName $resourceGroup.ResourceGroupName `
    -VirtualNetworkname $vnetName `
    -SubnetName $subnetName `
    -SecurityGroupName $securityGroupName `
    -PublicIpAddressName $publicIpAdName `
    -ImageName $imageName `
    -Size $size `
    -Credential $credential `
    -OpenPorts 3389;


# Stop VM
Stop-AzVM `
    -Name $vmName `
    -ResourceGroupName $resourceGroup.ResourceGroupName `
    -StayProvisioned `
    -Force;



#### Remove this for deployment ####
# Cleanup
#Remove-AzResourceGroup -Name $resourceGroupName;


# Disconnect
#Disconnect-AzAccount;
#### End remove this for deployment ####


