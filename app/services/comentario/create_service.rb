class Comentario::CreateService
  attr_reader :comentario

  def initialize(comentario)
    @comentario = comentario
  end

  def call
    @comentario.save
  end
end
