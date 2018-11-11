Rails.application.routes.draw do
  get 'expenses/index'
  get 'expenses/new'
  get 'expenses/create'
  get 'expenses/edit'
  get 'expenses/update'
  get 'expenses/destroy'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  resources :accounts
  resources :categories, only: [:new, :create]
  resources :budgets
  resources :operations
  resources :expenses
end
