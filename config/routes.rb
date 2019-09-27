# frozen_string_literal: true

Rails.application.routes.draw do

  resources :companies
  devise_for :users, skip: [:registrations]

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  root to: 'projects#index'

  resources :services
  resources :extras
  resources :projects
  resources :wares
  resources :project_extra_lines
  resources :customers
  resources :quotations
  resources :invoices
  resources :payments

  get '/change_locale', to: 'application#change_locale', as: :change_locale
  get '/projects/project_extra_lines/new_manual', to: 'project_extra_lines#new_manual'
  get '/projects/project_extra_lines/edit_manual/:id', to: 'project_extra_lines#edit_manual'

  get 'projects/accepted/:id' => 'projects#accepted', as: :accepted
  get 'invoices/paid/:id' => 'invoices#paid', as: :paid


end
