class PostagensController < ApplicationController
  include Paginatable

  def index
    @postagens = Postagem.where(user_id: current_user.id).page(params[:page]).per(5)
  end

  def show
    @postagem = Postagem.where(user_id: current_user.id, id: params[:id]).page(params[:page]).per(5)
  end

  def create
    @postagem = current_user.postagens.build(postagem_params)

    if Postagem::CreateService.new(@postagem).call
      render json: { message: 'Postagem Criada com Sucesso' }, status: :created
    else
      render json: { errors: @postagem.errors }, status: :unprocessable_entity
    end
  end

  def update
    @postagem = Postagem.find_by(id: params[:id])

    return render json: { errors: 'Postagem inexistente' }, status: :not_found if @postagem.nil?

    @service = Postagem::UpdateService.new(@postagem, postagem_params)

    if @service.call
      render json: { message: 'Postagem Atualizada' }, status: :ok
    else
      render json: { errors: @service.errors }, status: :unprocessable_entity
    end
  end

  def delete; end

  private

  def paginatable_model
    Postagem
  end

  def postagem_params
    params.require(:postagem).permit(:titulo, :texto)
  end
end
