Rails.application.routes.draw do
  resources :locations
  resources :membership_types
  resources :organizations
  resources :users, only: [:index]
  devise_for :users, controllers: { registrations: "users/registrations" }
  get 'home/index'

  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :carriers
end
