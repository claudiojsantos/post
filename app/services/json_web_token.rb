class JsonWebToken
  SECRET_KEY = ENV['SECRET_KEY']

  def encode(payload, exp = 24.hours.from_now)
    paylod[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  rescue JWT::DecodeError => e
    nil
  end
end
