# Server Setup

## Introduction

This document describes setting up a production or staging server after having [provisioned](provisioning.md) it. In
this context, setting up means:
 
1. Installing necessary software (including Ruby) and creating needed user and database accounts.
2. Install `nginx` web server
3. Obtaining a wildcard certificate for `*.stage(#).babywearing.exchange` and installing it (this includes doing
the necessary DNS challenge on the fly).

## Step

There is just one step, run:

```
    ansible-playbook setup.yml -i deploy/ansible/hosts -e target=stage2
```

You can now [deploy](deploy.md) the application to the server.

## Notes

1. This will take approximately 10 minutes.

2. Ansible is built around the concept of [idempotence](https://en.wikipedia.org/wiki/Idempotence). Therefore, you should
be able to run the setup playbook repeatedly (passing the same target, of course), without anything changing,
unless something in the playbook or environment changes. If you follow the output of running the playbook, each task
will let you know if it changed anything by virtue of the fact that its output will be yellow, whereas it will be green
if nothing changed. It will also print a summary at the end of the run showing how many changes there were.

3. If you see something changing where it should not be doing so, please file an issue.

4. If you have run this task for this server name before (that is, for example, for an instance of stage2 that has
been destroyed and you are rebuilding it), you may need to first remove it from your `~/.ssh/known_hosts` file to
avoid ssh from getting very suspicious and failing to let you connect in this step. You can do this by:
  
   ```
   ssh-keygen -f ~/.ssh/known_hosts -R stage2.babywearing.exchange
   ```
   
   Don't forget to change the server name to the correct one.
  
5. One cannot make unlimited TLS certs under a primary domain. Therefore, if you have need to debug something so that
you are running the setup playbook often (and thus requesting a lot of certs), you can change the URL to the
Let's Ecrypt [staging environment](https://letsencrypt.org/docs/staging-environment/). You will need to do that
in two places in the file `deploy/ansible/nginx/tasks/main.yml`. This will work exactly the
same as the production environment except it will allow you to generate a lot more certs and the browser will see 
the cert but just not trust it quite as much.    

