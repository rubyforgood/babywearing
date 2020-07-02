### After Deploy

* Since you still will have the key with which you deployed, you should be able to SSH to the newly
deployed servier by doing:

    `ssh -i ~/.ssh/babywearing-stage stage.babywearing.exchange`

For convenience I have the following in ~/.ssh/config:

```
   Host bwstage
      User babywearing
      Hostname stage.babywearing.exchange
      Port 22
      IdentityFile ~/.ssh/babywearing-stage
   
   Host bwstage2
      User babywearing
      Hostname stage2.babywearing.exchange
      Port 22
      IdentityFile ~/.ssh/babywearing-stage2
   
   Host bwstage3
      User babywearing
      Hostname stage3.babywearing.exchange
      Port 22
      IdentityFile ~/.ssh/babywearing-stage3
   
   Host bwstage4
      User babywearing
      Hostname stage4.babywearing.exchange
      Port 22
      IdentityFile ~/.ssh/babywearing-stage4
   
   Host bwp
      User babywearing
      Hostname babywearing.exchange
      Port 22
      IdentityFile ~/.ssh/babywearing-prod
```

This allows me to just do `ssh bwstage`, `ssh bwstage2`, `ssh bwp`, etc. Usually
all of these instances won't exist but it doesn't hurt to have them in there.

* To load the carrier images on a newly deployed server, ssh to the server and do:

     `ssh bwstage`
     
     `cd app/current`

     `RAILS_ENV=production bundle exec rake db:image_seeds:carriers`
     
     