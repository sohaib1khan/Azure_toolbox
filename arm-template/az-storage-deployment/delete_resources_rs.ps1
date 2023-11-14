# Define the resource group name
$resourceGroupName = "1-23844a37-playground-sandbox"

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



# Script usage: 
# ./SCRIPT_NAME.ps1 -force