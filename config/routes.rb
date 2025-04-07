require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  
  root 'transfers#index'
  resources :transfers, only: [:index]
end