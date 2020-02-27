Steps to manually deploy:

1. Build and push. (see build.md)
2. Deploy (see deploy.azure.md)

Still to do:

- implement domain and point Azure instances to them (the rest of these are on hold until this is done)
- TLS 
- integrate postmark on deployed instances
- add sidekiq and delayed and jobs (for, e.g., welcome and reminder emails)
- further refinements to and documentation of provisioning and deployment process
- move storage of images to Azure cloud storage
- possibly move postgres out of docker container and use Azure db instances
- configure server name in `docker/env/production/web` (it eventually goes in nginx conf in web container) so it
 isn't hard coded


 