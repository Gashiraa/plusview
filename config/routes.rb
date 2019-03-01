Rails.application.routes.draw do
  resources :admins
  resources :wares
  resources :services
  resources :projects
  resources :customers
  resources :invoices
  resources :payments
  resources :quotations

  root to: 'wares#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
