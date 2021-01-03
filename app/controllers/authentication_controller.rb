class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :login

  def login
    skip_authorization

    tg_auth_data = Telegram::TelegramAuth.authorize(params[:data].as_json)
    account = TelegramAccount.create_or_login_with(tg_auth_data)

    render json: account.user, include: '*.*.*'
  rescue StandardError => e
    render json: e, status: :forbidden
  end
end
