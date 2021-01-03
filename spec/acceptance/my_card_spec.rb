require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'My Card' do
  explanation 'my card'

  let(:photo_file) { fixture_file_upload('test.jpg', 'image/jpg') }

  let(:tg_auth_data) do
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

  let(:anthony) { TelegramAccount.create_or_login_with(tg_auth_data).user }
  let(:my_card) { anthony.primary_card }

  before do
    header 'authorization', "Bearer #{anthony.token}"
  end

  get '/my_cards' do
    example 'list my cards (with auth)' do
      do_request
      json_body = JSON.parse(response_body)
      expect(json_body.count).to eq 1
      my_card = json_body.first
      expect(my_card['fullname']).to eq 'A L'
      expect(my_card['primary']).to eq true
      expect(my_card['public']).to eq false
      expect(my_card['photos'].count).to eq 1
      expect(my_card.dig('social_urls', 0, 'value')).to eq 'https://t.me/internal_server_error'
    end

    example 'list my cards (no auth)' do
      header 'authorization', ''
      do_request

      expect(status).to eq 422
    end
  end

  get '/my_cards/:id' do
    let(:id) { my_card.id }

    example 'show my card' do
      do_request
      json_body = JSON.parse(response_body)
      expect(json_body['fullname']).to eq 'A L'
      expect(json_body['primary']).to eq true
      expect(json_body['public']).to eq false
      expect(json_body['photos'].count).to eq 1
      expect(json_body.dig('social_urls', 0, 'value')).to eq 'https://t.me/internal_server_error'
    end
  end

  post '/my_cards' do
    parameter :fullname
    parameter :description
    parameter :gender
    parameter :name_prefix
    parameter :organization
    parameter :public
    parameter :role
    parameter :email_attributes
    parameter :phone_attributes
    parameter :address_attributes
    parameter :website_urls_attributes
    parameter :social_urls_attributes
    parameter :hash_tags_attributes

    let(:fullname) { 'IT狗' }

    example 'create my card' do
      do_request
      json_body = JSON.parse(response_body)

      expect(json_body['fullname']).to eq 'IT狗'
    end
  end

  put '/my_cards/:id' do
    parameter :fullname
    parameter :description
    parameter :gender
    parameter :name_prefix
    parameter :organization
    parameter :public
    parameter :role
    parameter :emails_attributes
    parameter :phones_attributes
    parameter :addresses_attributes
    parameter :website_urls_attributes
    parameter :social_urls_attributes
    parameter :hash_tags_attributes
    parameter :photos_attributes

    let(:id) { my_card.id }
    let(:description) { 'IT狗做到嘔' }
    let(:emails_attributes) do
      [{ category: 'work', value: 'aaa@example.com' }]
    end

    let(:photos_attributes) do
      [{ image: photo_file }]
    end

    example 'update my card' do
      do_request
      json_body = JSON.parse(response_body)

      expect(json_body['description']).to eq 'IT狗做到嘔'
      expect(json_body.dig('emails', 0, 'value')).to eq 'aaa@example.com'
      expect(json_body['photos'].count).to eq 2
    end
  end
end
