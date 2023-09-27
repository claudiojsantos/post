class ComentariosController < ApplicationController
  def index
    @comentarios = current_user.comentarios.page(params[:page]).per(5)
  end

  def show
    @comentario = Comentario.where(id: params[:id]).page(params[:page]).per(5)
  end

  def create; end
end
