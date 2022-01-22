# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    it 'creates a new user' do
      post '/api/v1/users', params: { user: { name: 'user1', email: 'user1@test.com', password: 'password' } }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({
                                                'name' => 'user1',
                                                'email' => 'user1@test.com',
                                                'token' => JsonWebToken.encode(user_id: User.last.id)
                                              })
    end
  end
end
