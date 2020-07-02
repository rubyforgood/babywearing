# Multitenancy Info

1. This app is multi-tenant, using [acts_as_tenent](https://github.com/ErwinM/acts_as_tenant)

2. Each tenant is an organization. Each organization will have distinct carriers,etc.
The entities that will be separate are all the ones with `organization_id` fields,
plus any that belong to any records with `organization_id` fields (e.g. loans are
tied to things with `organization_id` even though they do not need such a field themselves).

3. The app will know which organization the user is in (or is visiting) by looking
at the subdomain.

4. There is a special organization with subdomain `admin`. This will manage all
non-organization records (at this time just `Categories`). It will have its own
set of users. This organization will have different menus (basically it will
only need access to non-organizational resources). See the `db/seeds.rb` for info
on which organizations and users exist after running seeds.

5. To access the organization in dev, use `<subdomain>.lvh.me:3000`.
