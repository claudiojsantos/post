class Postagem::UpdateService
  attr_reader :errors

  def initialize(postagem, params)
    @postagem = postagem
    @params = params
    @errors = []
  end

  def call
    return false unless @postagem

    if @postagem.update(@params) && @postagem.valid?
      true
    else
      @errors = @postagem.errors.full_messages
      false
    end
  end
end
