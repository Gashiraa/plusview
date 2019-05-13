# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  root to: 'wares#index'

  resources :services, constraints: lambda {|request| request.env['warden'].user.isAdmin}
  resources :extras, constraints: lambda {|request| request.env['warden'].user.isAdmin}
  resources :projects, constraints: lambda {|request| request.env['warden'].user.isAdmin}

  resources :wares
  resources :project_extra_lines
  resources :customers
  resources :quotations
  resources :invoices
  resources :payments

  get '/change_locale', to: 'application#change_locale', as: :change_locale

end
