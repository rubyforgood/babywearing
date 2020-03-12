Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations"}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'carriers#index'

  get 'home/index'

  resources :users, except: [:destroy, :new] do
    resources :memberships, except: :index, controller: 'users/memberships'
  end

  # TODO: this should go away, we don't need a whole resource, module and controller just to modify a field on a record
  # of a type that already has those things
  scope module: :users do
    resources :deactivate, only: :create
  end

  resources :signed_agreements, only: [:show, :create]
  resources :fee_types
  resources :agreements
  resources :locations
  resources :membership_types, except: :show

  resources :carriers do
    resources :loans, only: [:create, :edit, :new, :update], module: :carriers
  end

  get '/loan_listing', to: 'loan_listing#index', as: :loan_listing

  resources :photos, only: :destroy
  resources :categories
end
