module Request
  module AuthHelpers
    # usado para login em controllers
    def login_as(user)
      token = JsonWebToken.jwt_encode(user_id: user.id)
      {
        'Authorization' => "Bearer #{token}",
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end

    def without_login
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }
    end

    def base_url
      'http://localhost:3000'
    end
  end
end
