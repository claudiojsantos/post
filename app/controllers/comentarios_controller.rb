class ComentariosController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    @comentarios = current_user.comentarios.page(params[:page]).per(5)
  end

  def show
    @comentario = Comentario.where(id: params[:id]).page(params[:page]).per(5)
  end

  def create
    @comentario = Comentario.new(comentario_params)

    if Comentario::CreateService.new(@comentario).call
      render json: { message: 'Comentário Criada com Sucesso' }, status: :created
    else
      render json: { errors: @comentario.errors }, status: :unprocessable_entity
    end
  end

  private

  def paginatable_model
    Comentario
  end

  def comentario_params
    params.require(:comentario).permit(:nome, :comentario, :postagem_id)
  end
end
