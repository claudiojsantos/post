class ComentariosController < ApplicationController
  def index
    @comentarios = current_user.comentarios.page(params[:page]).per(5)
  end

  def show; end

  def update; end

  def create; end
end
