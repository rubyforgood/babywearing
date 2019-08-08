Rails.application.routes.draw do
  resources :signed_agreements, only: [:show, :create]
  resources :fee_types
  resources :agreements
  resources :locations
  resources :membership_types
  resources :organizations
  resources :users, only: [:index]
  resources :carriers
  resources :photos, only: :destroy
  devise_for :users, controllers: { registrations: "users/registrations" }
  # get 'home/index'
  get 'home/inventory'

  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'home#index'
  root 'home#inventory'
end
