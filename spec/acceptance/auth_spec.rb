require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Auth' do
  explanation 'authentication'

  post '/auth/login' do
    parameter :data, type: :string

    let(:data) do
      {
        id: 234_392_020,
        first_name: 'A',
        last_name: 'L',
        username: 'internal_server_error',
        photo_url: 'https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg',
        auth_date: 1_609_589_609,
        hash: 'dc9b82669e41c85e5c50d648e5a569fc65449998eef109627e68374e5fc7a049'
      }
    end

    example 'Login with valid telegrem account' do
      do_request
      expect(status).to eq 200

      json_body = JSON.parse(response_body)
      expect(json_body.dig('telegram_account', 'first_name')).to eq 'A'
      expect(json_body.dig('telegram_account', 'last_name')).to eq 'L'
      expect(json_body.dig('telegram_account', 'username')).to eq 'internal_server_error'

      expect(json_body.dig('telegram_account', 'avatar', 'url')).not_to be_nil
      expect(Jwt::Crypter.decode(json_body['token'])).to eq 'user_id' => User.last.id
    end

    example 'Login with invalid telegrem account' do
      do_request(
        data: {
          id: 123,
          first_name: 'A',
          last_name: 'L',
          username: 'internal_server_error',
          auth_date: 1_609_577_318,
          hash: '5709d4c18d863cb6c8978c75b77cd774c464f85094baf639b8ae65a7fca5c8d4'
        }
      )
      expect(status).to eq 403
      expect(JSON.parse(response_body)).to eq 'invalid_data'
    end
  end
end
