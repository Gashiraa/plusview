Rails.application.routes.draw do
  resources :admins
  resources :wares
  resources :services
  resources :projects
  resources :customers
  resources :invoices
  resources :payments
  resources :quotations

  devise_for :users
  root to: 'projects#index'

end
