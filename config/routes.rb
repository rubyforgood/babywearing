Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations"}

  get 'home/index'

  resources :users, except: [:destroy, :new] do
    resources :memberships, except: :index, controller: 'users/memberships'
    resources :signatures, except: %i[:destroy, :edit, :update], controller: 'users/signatures'
  end

  # TODO: this should go away, we don't need a whole resource, module and controller just to modify a field on a record
  # of a type that already has those things
  scope module: :users do
    resources :deactivate, only: :create
  end

  resources :email_templates

  resources :fee_types

  resources :agreements do
    resources :versions, controller: 'agreements/versions'
  end


  resources :locations
  resources :membership_types, except: :show

  resources :carriers do
    resources :loans, only: [:create, :edit, :new, :update], module: :carriers
  end

  get '/loan_listing', to: 'loan_listing#index', as: :loan_listing

  resources :photos, only: :destroy

  constraints subdomain: %w(admin) do
    root :to => "organizations#index", :as=> :subdomain_root
    resources :categories
    resources :organizations
  end

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  authenticate :user, lambda { |u| u.organization.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'carriers#index'

end
