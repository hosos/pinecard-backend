module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end

  class MissingToken < StandardError; end

  class InvalidToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from Pundit::NotAuthorizedError, with: :forbidden
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  private

  def forbidden(e)
    render json: { message: e.message }, status: :forbidden
  end

  def not_found(e)
    render json: { message: e.message }, status: :not_found
  end

  def unprocessable_entity(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end
end
