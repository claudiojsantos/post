class PostagensController < ApplicationController
  include Paginatable

  def index
    @postagens = Postagem.all.page(params[:page]).per(5)
  end

  def show; end

  def create; end

  def update; end

  def delete; end

  private

  def paginatable_model
    Postagem
  end
end
