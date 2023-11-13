#  Azure Virtual Machine Deployment Guide

This guide outlines the steps to create and manage a virtual machine (VM) in an existing Azure subscription and resource group.

## Prerequisites

Ensure you are working within an existing subscription and have the name of the resource group you want to use.

  

## Retrieve the Resource Group

  

Use the following command to get the details of your resource group:

```
Get-AzResourceGroup -Name "ResourceGroupName"
```

Replace `ResourceGroupName` with the name of your existing resource group.

&nbsp;

## Create a New Virtual Machine

Prepare the command with the required parameters:

```
PS /> $cred = Get-Credential
PS /> new-azvm -ResourceGroupName "<ResourceGroupName>" -Name "demovm" -Credential $cred -Location "eastus" -Image "Canonical:UbuntuServer:18.04-LTS:latest" -OpenPorts 22 -PublicIpAddressName "demovmip"
```

&nbsp;

Explanation of parameters:

- `-ResourceGroupName`: Specifies the resource group for the VM.
- `-Name`: Sets the VM's name (e.g., 'demovm').
- `-Credential`: Prompts for credentials (username and password) for the VM.
- `-Location`: Specifies the deployment location (e.g., 'eastus').
- `-Image`: Defines the OS image for the VM (e.g., Ubuntu Server).
- `-OpenPorts`: Opens specified ports (e.g., 22 for SSH).
- `-PublicIpAddressName`: Assigns a name to the VM's public IP address.

&nbsp;

## Check Deployment Status

To inspect the deployment details:

```
PS /> $vm = Get-AzVM -Name "demovm" -ResourceGroupName "<ResourceGroupName>"
PS /> $vm
```

&nbsp;

## Select Individual Item

To get specific information such as the network interface (NIC) and public IP address, use:

```
# Get the NIC associated with the VM
$nic = Get-AzNetworkInterface -ResourceGroupName "<ResourceGroupName>" -Name "demovm"

# Get the public IP address associated with the NIC
$publicIp = Get-AzPublicIpAddress -Name $nic.IpConfigurations[0].PublicIpAddress.Id.Split("/")[-1]

# Output the public IP address
"The public IP address of the VM is: $($publicIp.IpAddress)"
```

&nbsp;

## Delete All Resources Within a Resource Group

To remove all resources within the resource group without deleting the group itself:

1.  Create a script file named `delete_resources_rs.ps1`.
2.  Copy and paste the following script:

```
# Define the resource group name
$resourceGroupName = "<ResourceGroupName>"

# Get all resources in the resource group
$resources = Get-AzResource -ResourceGroupName $resourceGroupName

# Loop through each resource and delete it
foreach ($resource in $resources) {
    # Output the resource being deleted
    Write-Output "Deleting resource: $($resource.ResourceName) of type: $($resource.ResourceType)"
    
    # Delete the resource
    Remove-AzResource -ResourceId $resource.ResourceId -Force -AsJob
}

# Output completion message
Write-Output "All resources in the resource group $resourceGroupName have been scheduled for deletion."
```

3.  Execute the script in PowerShell:

```
PS /> ./delete_resources_rs.ps1
```

&nbsp;

## Additional Notes

- Replace all `<ResourceGroupName>` placeholders with your actual resource group name.
- Replace all `<SubscriptionId>` placeholders with your actual subscription ID.
- It is recommended to review each command and understand its impact before execution.

&nbsp;