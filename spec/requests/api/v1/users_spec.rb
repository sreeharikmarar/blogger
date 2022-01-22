# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    context 'valid request' do 
      it 'creates a new user when the request is valid' do
        post '/api/v1/users', params: { user: { name: 'user1', email: 'user1@test.com', password: 'password' } }
  
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({
                                                  'name' => 'user1',
                                                  'email' => 'user1@test.com'
                                                })
      end
    end
    
    context 'invalid request' do 
      it 'fails when the name is invalid' do
        post '/api/v1/users', params: { user: { name: 'us', email: 'user1@test.com', password: 'password' } }
  
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ 
                                                  "error"=>"Name is too short (minimum is 3 characters)"
                                                })
      end

      it 'fails when the email is invalid' do
        post '/api/v1/users', params: { user: { name: 'user1', email: 'user1', password: 'password' } }
  
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ 
                                                  "error"=>"Email is invalid"
                                                })
      end

      it 'fails when the password is invalid' do
        post '/api/v1/users', params: { user: { name: 'user1', email: 'user1@test.com', password: '' } }
  
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({
                                                    "error"=>"Password can't be blank"
                                                })
      end
    end
  end
end
