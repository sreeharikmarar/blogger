# frozen_string_literal: true

Rails.application.routes.draw do
  get '/ping', to: 'health_check#ping'

  namespace :api do
    namespace :v1 do
      post '/auth/user', to: 'authentication#authenticate'
      resources :users, only: [:create]
      resources :posts, param: :id, only: [:create, :index] do
        resources :comments, only: [:create]
      end
    end
  end
end
