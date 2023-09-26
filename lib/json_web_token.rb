class JsonWebToken
  SECRET_KEY = ENV['SECRET_KEY']

  class << self
    def jwt_encode(payload, exp = 1.day.from_now)
      raise ArgumentError, 'exp should be a Time or DateTime object' unless exp.is_a?(Time) || exp.is_a?(DateTime)

      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY, 'HS256')
    end

    def jwt_decode(token)
      decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })[0]
      ActiveSupport::HashWithIndifferentAccess.new decoded
    rescue JWT::DecodeError => e
      raise CustomError::InvalidToken, 'Token Inválido'
    end
  end
end
