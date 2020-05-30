### Quick Deploy

This document summarizes the [provisioning](provisioning.md), [setup](setup.md) and [deploy](deploy.md) steps described
in more detail elsewhere.

#### Steps (replace server name as appropriate)

1. Server provision:

    ```
     ansible-playbook provision.yml -e target=stage2
    ``` 
    
2. Server setup

    ```
    ansible-playbook setup.yml -i deploy/ansible/hosts -e target=stage2
    ```     

3. Server directory setup (for first time on server only):

    ```
    mina -f deploy/deploy.rb setup server_name=stage2
   ```
   
4. Deploy   

    ```
    mina -f deploy/deploy.rb deploy server_name=stage2 
    ``` 
   
5. DB Seed (first time on server only)   

    ```
    mina -f deploy/deploy.rb seed server_name=stage2 
    ``` 
