# frozen_string_literal: true

Rails.application.routes.draw do
  get '/ping', to: 'health_check#ping'
  
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]
      post '/auth/user', to: 'authentication#authenticate'
    end
  end
end
