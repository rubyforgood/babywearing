### Introduction

These documents describe provisioning a server and deploying the application to that server. Once your local machine
is setup with the proper tools and credentials, this all can be done with less than a handful of commands and in under 15
minutes (most of which is time waiting for the code to run).

1. [Requirements](requirements.md) - shows you how to set up your local machine for privisioning.
2. [Provisioning](provisioning.md) - shows you how to do a provisioning.



- Add AD user. Give user access to subscription by going to subscription and adding Owner (or lesser) role

- brew install azure-cli

- az login

- az ad sp create-for-rbac --name http://babywearing.exchange

- update ~/.azure/credentials with output, in format:

(no quotes needed)

[default]
subscription_id=(redacted)
client_id=(redacted)
secret=(redacted)
tenant=(redacted)

- manually change stage# in project to stage<whatever number you are using>

- pip3 install ansible
- pip3 install 'ansible[azure]'

- setup ansible vault credentials:
-- make environment variable pointing to (project directory)/.vault_pass.txt
-- get the password from someone and put that in this file

- azure credentials : https://dev.to/azure/setting-up-the-azure-credentials-file-41o3

- run provision.yml

- add firewall rule in db server

ansible-galaxy install suzuki-shunsuke.rbenv
ansible-galaxy install suzuki-shunsuke.rbenv-module

ansible-playbook setup.yml -i hosts -e target=stage2

mina -f deploy/deploy.rb setup

mina -f deploy/deploy.rb setup

create config/master.key

mina -f deploy/deploy.rb deploy

mina -f deploy/deploy.rb seed

todo:

- TLS 
- integrate postmark on deployed instances
- add sidekiq and delayed and jobs (for, e.g., welcome and reminder emails)
- move storage of images to Azure cloud storage





