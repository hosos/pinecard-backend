require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Auth' do
  explanation 'authentication'
  header 'Content-Type', 'application/json'

  get '/auth/login' do
    example 'Login with Telegrem' do
      do_request
      expect(status).to eq 200
    end
  end
end
