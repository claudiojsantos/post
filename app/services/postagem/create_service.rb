class Postagem::CreateService
  attr_reader :postagem

  def initialize(postagem)
    @postagem = postagem
  end

  def call
    @postagem.save
  end
end
