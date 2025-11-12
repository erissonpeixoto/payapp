Rails.application.routes.draw do

  devise_for :users
  resources :configurations
  resources :categories
  resources :payments
  resources :expenses
  resources :revenues
  
  root 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
