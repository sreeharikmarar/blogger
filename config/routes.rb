# frozen_string_literal: true

Rails.application.routes.draw do
  get '/ping', to: 'health_check#ping'

  namespace :api do
    namespace :v1 do
      post '/auth/user', to: 'authentication#authenticate'
      resources :users, only: %i[create]
      resources :posts, only: %i[create]
    end
  end
end
