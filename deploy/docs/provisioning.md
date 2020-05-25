# Server Provisioning

## Introduction

Provisioning is the process of setting up a server (and database instance) to run the application. For this probject,
this will mean staging server(s) and one production server. If these servers are already setup, you do not need to
do any provisioning.

Before you can do provisioning, you will need to make sure you have the [requirements](requirements.md) in place.

You will need to select a name for your instance. If you are provisioning for production, this will be `prod`. Otherwise,
it will be `stage`, `stage1`, `stage2`, etc. There is no strict requirement that they be named this way, but it is
a good convention. Before doing this, check the existing [resource groups](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups) in Azure.
There will be an existing group called `babywearing-stage(#)` if the name you want to use is already taken. If not,
you can proceed using the server name you want. 

For purposes of the examples in the rest of this document, we will assume we are provisioning `stage1`.

## Steps

1. Go to the project root directory.
2. Run:

    ```
    ansible-playbook provision.yml -e target=stage1
    ```

    This will take about 5-7 minutes.

3. (Optional) The terminal output should indicate whether provisioning was successful, but to further verify this,
 go to the [Azure portal resource goups list](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups) and find the newly created resource group for your server. If
 you click on the resource group you should see your VM, database instance, public IP, etc. 
 
     It will look something like this:
     
     [image](images/azure_resource_group.png)
    
4. At this point you should have a server and a local private key (in `~/.ssh) that will allow you to ssh to the server
and set it up. To do so, please see [setup](setup.md).


## Notes
    
1. Please keep in mind that although we have a generous sponsorship from Azure, it is limited. Provisioning and
running servers uses these credits, so please do not do so wastefully. And if you provision a server that you
need to keep around but will not need to be up and running all the time, please stop the VM when not in use.

2. Ansible is built around the concept of [idempotence](https://en.wikipedia.org/wiki/Idempotence). Therefore, you should
be able to run the provisioning playbook repeatedly (passing the same target, of course), without anything changing,
unless something in the playbook or environment changes. If you follow the output of running the playbook, each task
will let you know if it changed anything by virtue of the fact that its output will be yellow, whereas it will be green
if nothing changed. It will also print a summary at the end of the run showing how many changes there were.

3. If you see something changing where it should not be doing so, please file an issue.

