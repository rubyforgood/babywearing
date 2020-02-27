#!/bin/bash

# This is deployment related and comes from
# https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-service-principal
#
# We are using it so we can push a new image (built as documented in docs/build/deployment/build.md) to the Docker
# registry in Azure, without logging in interactively. This script simply generates the needed username
# and password (the user in Azure parlance is called a "service principal").
# In general this will not need to be run often.

# This will only work if you have the Azure CLI installed AND are logged in via the Azure CLI to an ActiveDirectory
# owner for the MAB subscription

# The two values output at the end of the script will by used by CI to login to Docker before pushing the Docker
# image to the repository in Azure. They will be entered as ENV variables in Travis (DOCKER_USERNAME/DOCKER_PASSWORD).

# ACR_NAME: The name of your Azure Container Registry
# SERVICE_PRINCIPAL_NAME: Must be unique within your AD tenant
ACR_NAME=babywearing
SERVICE_PRINCIPAL_NAME=acr-service-principal

# Obtain the full registry ID for subsequent command args
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)

# Create the service principal with rights scoped to the registry.
# Default permissions are for docker pull access. Modify the '--role'
# argument value as desired:
# acrpull:     pull only
# acrpush:     push and pull
# owner:       push, pull, and assign roles
SP_PASSWD=$(az ad sp create-for-rbac --name http://$SERVICE_PRINCIPAL_NAME --scopes $ACR_REGISTRY_ID --role acrpush --query password --output tsv)
SP_APP_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)

# Output the service principal's credentials; use these in your services and
# applications to authenticate to the container registry.
echo "Service principal ID: $SP_APP_ID"
echo "Service principal password: $SP_PASSWD"
