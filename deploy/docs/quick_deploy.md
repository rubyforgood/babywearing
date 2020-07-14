### Quick Deploy

This document summarizes the [provisioning](provisioning.md), [setup](setup.md) and [deploy](deploy.md) steps described
in more detail elsewhere.

For production provisioning, setup and deploy, use target/server_name `prod`

#### Steps (from project root; replace server name as appropriate)

1. Server provision:

    ```
     ansible-playbook deploy/ansible/provision.yml -e target=stage
    ``` 
    
2. Server setup

    ```
    ansible-playbook deploy/ansible/setup.yml -i deploy/ansible/hosts -e target=stage2
    ```     

3. Server directory setup (for first time on server only):

    ```
    mina -f deploy/deploy.rb setup server_name=stage2
   ```
   
4. Deploy   

    ```
    mina -f deploy/deploy.rb deploy server_name=stage2 [branch=optional] 
    ``` 
   
5. DB Seed (first time on server only)   

    ```
    mina -f deploy/deploy.rb seed server_name=stage2 
    ``` 
6. Carrier images (first time only)

    ```
   mina -f deploy/deploy.rb 'rake[db:image_seeds:carriers]' server_name=stage2
   ```