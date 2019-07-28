Rails.application.routes.draw do
  resources :fee_types
  resources :agreements
  resources :locations
  resources :membership_types
  resources :organizations
  resources :carriers
  resources :photos, only: :destroy
  devise_for :users, controllers: { registrations: "users/registrations" }
  get 'home/index'

  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
