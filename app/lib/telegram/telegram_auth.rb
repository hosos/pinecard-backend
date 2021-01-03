class Telegram::TelegramAuth
  def self.authorize(data)
    data = data.deep_transform_keys(&:to_sym)
    raise StandardError, 'expired' unless Rails.env.test? || Time.now.to_i - data[:auth_date].to_i <= 86_400

    raise StandardError, 'invalid_data' unless OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new('sha256'),
      Digest::SHA256.digest(Settings.app.telegram.bot_token),
      data.except(:hash).sort.map { |k, v| "#{k}=#{v}" }.join("\n")
    ) == data[:hash]

    data
  end
end
