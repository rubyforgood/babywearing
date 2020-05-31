## Requirements for Provisioning and Deploying

### Azure

Babywearing is deployed to Azure servers. Therefore, before deploying, a server must be setup. This is
called provisioning. Provisioning is done with [Ansible](https://docs.ansible.com).

#### Steps

1. The below steps assume you are on MacOS (and you are using homebrew). They can most certainly be done from Linux or
Windows, but of course some of the steps would be slightly different.

2. The commands below are run in the MacOS terminal.

3. Install the Azure CLI:

       brew install azure-cli
    
4. Get credentials. You will need someone with admin on Azure to add you as an admin user in active directory
   and for them to give you rights on the project's subscription. You will also need the Ansible vault password.
   Ansible vault is described more fully below.
   
5. Login to Azure using the CLI:

       az login    
       
6. Verify that you have access to the subscription:       

    ```
    az account list
    ```
 
    You should get back something that looks like this: 

    ```

    [
      {
        "cloudName": "AzureCloud",
        "homeTenantId": "15f64fdc-1114-6b03-413d-da6f100f20ca",
        "id": "a4e64176-b12b-218c-9ce4-293c55e337a7",
        "isDefault": true,
        "managedByTenants": [],
        "name": "Microsoft Azure Sponsorship",
        "state": "Enabled",
        "tenantId": "15f64fdc-1114-6b03-413d-da6f100f20ca",
        "user": {
          "name": "rubyforgood@example.com",
          "type": "user"
        }
      }
    ]
    ```    

    If you don't see this, you may not have been given enough authorization.

7. Generate credentials:

       az ad sp create-for-rbac --name http://babywearing.exchange
       
    and save the output for the next step.

8. Create a file at ~/.azure/credentials with contents:

        [<subscription id>]
        client_id=<client id from above>
        secret=<from above>
        tenant=<from above>
        
This will authenticate all actions involved with azure while running the Ansible playbooks.

9. We are using [ansible-vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) to store the database
 credentials and any others to be added. The vault is at `deploy/ansible/vault.yml`. You will need to get the 
 password for the vault, probably from the same person that sets up your Azure account. Once you have it, the easiest
 way to use it is to:
 
    a. Put the password in a file called `.vault_pass.txt`. Just one line by itself. Make sure it is in the root of
    the project.
    
    b. Create an environment variable `ANSIBLE_VAULT_PASSWORD_FILE` and set it equal to the path of `.vault_pass.txt`
    
    c. To verify that it is working, run:
     
       ansible-vault edit deploy/ansible/vault.yml     

Make sure you never commit the password file. Once this is setup you will not need to think about it again (unless 
you need to modify the passwords for some reason, which you would do using the command in the last step above), as
the playbooks will now be able to read the encrypted vault as needed.

### Python and Ansible

#### Introduction

There are many ways to install Ansible and Python. It is best not to use the system Python. For more information,
see [this article](https://opensource.com/article/19/5/python-3-default-mac). I suggest you follow the instructions
there to use `pyenv`. Especially if you are used to `rbenv`. They are very similar. The rest of these steps assume
you have installed python 3 and pip is available.

#### Steps        
       
1. Install Ansible:

       pip install ansible
       
2.  Install the dependencies for the Ansible Azure Collection. Download the requirements text file from:

         https://raw.githubusercontent.com/ansible-collections/azure/dev/requirements-azure.txt

3. Install the dependencies:

       pip install -r requirements-azure.txt
       
4. Install the collection:

       ansible-galaxy collection install azure.azcollection
       
5. Install required roles:

       ansible-galaxy install suzuki-shunsuke.rbenv
       ansible-galaxy install suzuki-shunsuke.rbenv-module 
       
You should now be ready to [provision](provision.md) a server.                    
       