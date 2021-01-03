class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  def authorize_request
    token = (request.headers['authorization'] || '').gsub('Bearer ', '')
    raise ExceptionHandler::MissingToken unless token

    token_data = Jwt::Crypter.decode(token)
    raise ExceptionHandler::InvalidToken unless token_data

    @current_user = User.find(token_data['user_id'])
  end
end
