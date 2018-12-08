Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :accounts
  resources :categories
  resources :budgets
  resources :operations
  resources :template_operations
  resources :settings
end
