require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  let!(:user) { create(:user, name: 'user1') }
  let(:token) { JsonWebToken.encode(user_id: user.id)}
  let(:params) do 
    {
      'post': {
        'title': 'Recusandae minima consequatur',
        'content': 'Recusandae minima consequatur. Expedita sequi blanditiis. Ut fuga et'
      }
    }
  end
  
  let(:headers) do 
    {
      HTTP_AUTHORIZATION: "JWT #{token}" 
    }
  end

  describe 'POST /api/v1/posts' do
    context 'valid request' do
      it 'creates a new post when the request is valid' do
        post '/api/v1/posts', params: params, headers: headers

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({
                                                  'title' => 'Recusandae minima consequatur',
                                                  'content' => 'Recusandae minima consequatur. Expedita sequi blanditiis. Ut fuga et',
                                                  'author' => 'user1'
                                                })
      end
    end

    context 'invalid request' do
      it 'fails when the token is not present' do
        post '/api/v1/posts', params: params

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq({
                                                  'error' => 'Not Authorized'
                                                })
      end

      it 'fails when the title is not present' do
        params = {
            'post': {
              'title': '',
              'content': 'Recusandae minima consequatur. Expedita sequi blanditiis. Ut fuga et'
            }
        }

        post '/api/v1/posts', params: params, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({
                                                  "error"=>"Title can't be blank"
                                                })
      end
    end
  end
end
