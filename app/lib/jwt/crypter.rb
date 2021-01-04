class Jwt::Crypter
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.credentials.secret_key_base

  def self.encode(payload, exp = nil)
    payload[:exp] = exp.to_i.minutes.from_now.to_i if exp
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET).first

    HashWithIndifferentAccess.new body
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end
