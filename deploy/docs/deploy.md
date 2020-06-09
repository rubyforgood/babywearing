# Deployment

## Introduction

This document describes deployment of the application to a server that is already [setup](setup.md). This will show
you how to do it manually. It will eventually be done from CI so it may not need to be done manually very often.

Deployment is done using [mina](https://github.com/mina-deploy/mina). It works similarly to [Capistrano](https://capistranorb.com)
but is faster and perhaps simpler.

All operations should be run from the root of the project.

When deploying to production, use `server_name=prod`

## One-time Steps (i.e. on a new server)

1. Setup the required directories:

        mina -f deploy/deploy.rb setup server_name=stage2 [or whatever name you are using]
                   
2. Deploy the app. Only `master` is deployed, but this can be set in `deploy.rb`:

        mina -f deploy/deploy.rb deploy server_name=stage2 

3. Seed the database:

       mina -f deploy/deploy.rb seed server_name=stage2
      
   The seed step will give you the info about the built-in users. Note this so you can log in as them.

4. Seed the carrier images:

       mina -f deploy/deploy.rb 'rake[db:image_seeds:carriers]' server_name=stage2

    This will take a few minutes.

5. Check the app in browser:   https://midatlantic.stage2.babywearing.exchange
           
## Recurring deploy step
    
Whenever code changes in `master`, push changes and then run:

       mina -f deploy/deploy.rb deploy server_name=stage2 

If you want to deploy a branch other than master:

       mina -f deploy/deploy.rb deploy server_name=stage2 branch=mybranch 
         