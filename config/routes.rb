Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations"}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'carriers#index'

  get 'home/index'

  resources :users, except: [:destory, :show, :new]
  scope module: :users do
    resources :deactivate, only: :create
  end

  resources :signed_agreements, only: [:show, :create]
  resources :fee_types
  resources :agreements
  resources :locations
  resources :membership_types

  resources :carriers do
    resource :loans, only: [:new, :create], module: :carriers
  end

  resources :photos, only: :destroy
  resources :categories
end
