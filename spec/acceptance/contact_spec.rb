require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Contact' do
  explanation 'contact'

  let(:photo_file) { fixture_file_upload('test.jpg', 'image/jpg') }

  let(:anthony) do
    TelegramAccount.create_or_login_with(
      id: 234_392_020,
      first_name: 'A',
      last_name: 'L',
      username: 'internal_server_error',
      photo_url: 'https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg',
      auth_date: 1_609_589_609,
      hash: 'dc9b82669e41c85e5c50d648e5a569fc65449998eef109627e68374e5fc7a049'
    ).user
  end

  let(:mary) do
    TelegramAccount.create_or_login_with(
      id: 234_392_021,
      first_name: 'M',
      last_name: 'A',
      username: 'mary',
      photo_url: 'https://t.me/i/userpic/320/0HsMKYOWlgnBA2Httlfb3NBMp50KmdI4fD8tsNZu2js.jpg',
      auth_date: 1_609_589_609,
      hash: 'dc9b82669e41c85e5c50d648e5a569fc65449998eef109627e68374e5fc7a010'
    ).user
  end

  let(:anthony_card) { anthony.primary_card }
  let(:mary_card) { mary.primary_card }

  let(:anthony_token) { "Bearer #{anthony.token}" }
  let(:mary_token) { "Bearer #{mary.token}" }

  post '/contact_requests' do
    parameter :message
    parameter :friend_card_id
    parameter :owner_card_id

    let(:message) { 'hello' }
    let(:owner_card_id) { anthony_card.id }
    let(:friend_card_id) { mary_card.id }

    example 'create contact requests' do
      header 'authorization', "Bearer #{anthony.token}"
      do_request
      json_body = JSON.parse(response_body)
      expect(json_body['status']).to eq 'pending'
      expect(json_body['owner_card_id']).to eq owner_card_id
      expect(json_body['friend_card_id']).to eq friend_card_id
    end
  end
end
