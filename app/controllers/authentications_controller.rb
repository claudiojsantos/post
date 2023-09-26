class AuthenticationsController < ApplicationController
  skip_before_action :authorized

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      @token = JsonWebToken.jwt_encode({ user_id: @user.id })
      render :login, status: :ok
    else
      render json: { error: 'Credenciais Inválidas' }, status: :unauthorized
    end
  end
end
