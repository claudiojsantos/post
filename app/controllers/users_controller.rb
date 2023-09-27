class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = User.where(id: params[:id]).page(params[:page]).per(5)
  end

  def update
    @user = User.find_by(id: params[:id])

    return render json: { errors: 'Usuário inexistente' }, status: :not_found if @user.nil?

    @service = User::UpdateService.new(@user, user_params)

    if @service.call
      render json: { message: 'Usuário Atualizado' }, status: :ok
    else
      render json: { errors: @service.errors }, status: :unprocessable_entity
    end
  end

  def create; end

  def delete; end

  private

  def paginatable_model
    User
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
