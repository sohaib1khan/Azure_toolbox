This guide will walk you through the process of deploying a web app to Azure using the Azure CLI.

## Prerequisites

- Azure CLI installed  
- An Azure account

&nbsp;

## Setting Up Environment Variables

Set up the following environment variables for use in later commands:

```
export RESOURCE_GROUP=RESOURCE-GROUPNAME
export AZURE_REGION=eastus
export AZURE_APP_PLAN=PREFIX_NAME_REPLACE_ME-$RANDOM
export AZURE_WEB_APP=PREFIX_NAME_REPLACE_ME-$RANDOM
```

## List Your Resource Groups

If you have several resource groups, you can filter the list to find your specific group:

```
az group list --query "[?name == '$RESOURCE_GROUP']"
```

## Creating the App Service Plan

Create an App Service plan:

```
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
```

**Note:** This command can take several minutes to complete.

Verify the creation of the service plan:

```
az appservice plan list --output table
```

## Creating the Web App

Create the web app with the following command:

```
az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN
```

Verify the web app creation:

```
az webapp list --output table
```

## Accessing the Web App

To find your web app URL:

```
site="http://$AZURE_WEB_APP.azurewebsites.net"
echo $site
```

To get the default HTML of the app:

```
curl $site
```

## Deploy Code from GitHub

Deploy sample code from a GitHub repository:

```
az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration
```

Once the deployment is complete, you can visit your site or use `curl` to view the "Hello World" page:

```
curl $site
```

Replace `$site` with your actual web app URL as echoed previously.
