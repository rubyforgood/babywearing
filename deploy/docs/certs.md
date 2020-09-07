# TLS Certificates

## Introduction

The Ansible setup playbook automatically installs Lets Encrypt TLS certs as part of the server provisioning and setup
process (see the `certs` role in the `deply/ansible` directory). These certs require renewal at least every 90 days.
This renewal has to be run manually.

TODO: The renewal playbook can be tailored to be run automatically on the server via a cron job. This would require
installing ansible on the server (with dependencies) and having the required keys copied to the babywearing user on the server. This
could be done by modifying the [setup playbook](./setup.md) to install the dependencies and create the cron job.

## Renewal Step

There is a playbook in the `deploy/ansible` directory called `renew_certs.yml`, so initiating the renewal simply
involves running the following command (assuming you have the requirements and install keys as described in the
requirements and provisioning docs):

    ansible-playbook deploy/ansible/renew_certs.yml -i deploy/ansible/hosts -e target=stage

Remember to switch target to `prod` if updating the cert on production.
