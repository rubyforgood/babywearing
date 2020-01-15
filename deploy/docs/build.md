**Steps to build image needed to deploy to Azure:**
**doc is WIP as deploy process is not fully fleshed out**

The steps below are for manually deploying using docker. It is mostly here for informational purposes since these
steps have been integrated into Travis CI. See .travis.yml for more info.

----------------------
Required:

* Azure login - have someone add you as member of MAB account (NO, you cannot borrow someone's login/password)
* Azure CLI installed - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
* Docker installed - https://www.docker.com/products/docker-desktop
* Most of this and the deploy stuff will I hope mostly eventually be done through CI but for now this documents the process.
--------------------

**General Info**

The set of steps in this document involve just building a Docker image and pushing it to a repository. The image is
the same regardless of the environment you intend to deploy it to. In other words, all environments (prod, stage, etc.)
use the same image.

The image will go into a docker registry called `babywearing` which is in a resource group called `midatlantic_babywearing_registries`.
Resource groups on Azure are just logical groupings of resources. In our case, we will keep images in one group
and each deployment (i.e. stage, prod, etc.) in another. 

**Steps**

* Perform these steps in a terminal in the root of the Rails project.

* The below assumes defaults have been configured for `az` as follows:

      az configure --defaults group=midatlantic_babywearing_registries acr=babywearing 

* For this build you will need to login to azr and to the repository:

      az login
      
      az acr login
    
* Build the image:

      docker build -f Dockerfile.prod -t babywearing.azurecr.io/babywearing:prod .
        
* Push the image (this takes 15-20 minutes, depending on your upload bandwidth):

      docker push babywearing.azurecr.io/babywearing:prod     

If successful, you should see the new (or updated) image in the Azure portal.

Or in the CLI you will see the updated timestamp:

    az acr repository show --repository babywearing
    