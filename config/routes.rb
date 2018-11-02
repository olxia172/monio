Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :accounts
  resources :categories, only: [:new, :create]
  resources :budgets
  resources :operations
end
