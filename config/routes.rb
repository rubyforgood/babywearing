Rails.application.routes.draw do
  resources :agreements
  resources :locations
  resources :membership_types
  resources :organizations
  devise_for :users
  get 'home/index'

  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :carriers
end
