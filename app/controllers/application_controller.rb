class ApplicationController < ActionController::API
  include Pundit
  include ExceptionHandler

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

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
