
# Setup intructions
1. Open [babywearing GitHub page](https://github.com/rubyforgood/babywearing) and click the ⑂ Fork button.

2. Clone your copy to your local machine with `$ git clone git@github.com:YOUR-GITHUB-USER-NAME/babywearing.git`

3. Install dependencies by running `bundle install`

4. Configure your remote so that it points to the upstream repository in Git with `git remote add upstream https://github.com/rubyforgood/babywearing.git`

5. Run `rake db:setup` to set up the database.

6. Optional: run `rake db:image_seeds:carriers` to seed the carrier images. This takes several minutes.
