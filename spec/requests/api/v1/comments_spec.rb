# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  let!(:user) { create(:user, name: 'user1') }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let!(:post_1) { create(:post, user_id: user.id) }

  let(:params) do
    { 
      'comment': {
        'description': 'Recusandae minima consequatur'
      }
    }
  end

  let(:headers) do
    {
      HTTP_AUTHORIZATION: "JWT #{token}"
    }
  end

  describe 'POST /api/v1/posts/:post_id/comments' do
    context 'valid request' do 
      it 'creates a new comment when the request is valid' do
        post "/api/v1/posts/#{post_1.id}/comments", params: params, headers: headers

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({
                                                  'description' => 'Recusandae minima consequatur',
                                                  'user' => 'user1'
                                                })
      end
    end

    context 'invalid request' do 
      it 'fails when the request is valid' do
        post "/api/v1/posts/#{post_1.id}/comments", params: params

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq({
                                                  'error' => 'Not Authorized'
                                                })
      end
    end
  end
end
