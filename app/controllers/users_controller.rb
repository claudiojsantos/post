class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
  end

  def update
  end

  def create
  end

  def delete
  end
end
