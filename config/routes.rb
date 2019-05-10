Rails.application.routes.draw do
  resources :project_extra_lines
  resources :extras
  resources :admins
  resources :wares
  resources :services
  resources :projects
  resources :customers
  resources :invoices
  resources :payments
  resources :quotations

  root to: 'projects#index'

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
end
