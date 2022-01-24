# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Authentications', type: :request do
  describe 'user authentication' do
    let!(:user) { create(:user, name: 'user1', email: 'user1@test.com', password: 'password') }

    it 'authenticates a user when the credentials are valid' do
      post '/api/v1/auth/user', params: { email: 'user1@test.com', password: 'password' }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({
                                                'token' => JsonWebToken.encode(user_id: user.id)
                                              })
    end

    it 'fails to authenticate a user when the crentials are invalid' do
      post '/api/v1/auth/user', params: { email: 'user1@test.com', password: 'random' }

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({
                                                'error' =>
                                                  {
                                                    'user_authentication' => 'invalid credentials'
                                                  }
                                              })
    end
  end
end
