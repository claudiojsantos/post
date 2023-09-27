class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = User.where(id: params[:id]).page(params[:page]).per(5)
  end

  def update
  end

  def create
  end

  def delete
  end
end
