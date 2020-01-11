**Steps to deploy to Azure:**
**doc is WIP (i.e. NOT COMPLETE YET):**

----------------------
Required:

* Azure login and have someone add you as member of MAB account (NO, you cannot borrow someone's login/password)
* Azure CLI installed 
* Docker installed (link to Docker Desktop goes here)
* This stuff will I hope mostly eventually be done through CI but for now this documents the process.
--------------------
* push image with code changes to repository (see `build.md`)

* Log in (you don't need params if you configured defaults as in `build.md`)

      az acr login --name babywearing -g midatlantic_babywearing_registries / log in to resource group with images in it

* Get the subscription id.

      sub=$(az account show --query "id" -o tsv)

* Create the VM (this is ONLY on first deploy to an instance)

      docker-machine create -d azure /
       --azure-subscription-id $sub /
       --azure-ssh-user babywearing /
       --azure-open-port 80 /
       --azure-size "Standard_B2s" / 
       --azure-resource-group midatlantic_babywearing_stage / # rg..one per instance
       --azure-location "eastus" /
         babywearing-stage  # name of VM
 
* ssh to the new VM

      docker-machine ssh babywearing-stage
    
* get the internal IP

      ifconfig eth0 

* Need to change permissions but we should find a way around this:

      sudo chmod 666 /var/run/docker.sock  / :(  https://stackoverflow.com/questions/48957195/how-to-fix-docker-got-permission-denied-issue   

* Init a new docker swarm (replace ip below with internal IP found above)

      docker swarm init --advertise-addr 192.168.0.4
 
* Deploy build to swarm


      docker stack deploy -c docker-stack.yml babywearing_stage --with-registry-auth / from project directory
 
* To see status of startup:

      docker service ps --no-trunc babywearing_web 
      
      
      