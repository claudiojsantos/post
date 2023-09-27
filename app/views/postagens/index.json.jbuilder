json.postagens do
  json.array! @postagens do |postagem|
    json.id postagem.id.to_s
    json.author postagem.user.name
    json.email postagem.user.email
    json.criado postagem.created_at
    json.titulo postagem.titulo
    json.texto postagem.texto

    json.comentarios postagem.comentarios do |comentario|
      json.nome comentario.nome
      json.comentario comentario.comentario
      json.data comentario.created_at
    end
  end
end

json.current_page @postagens.current_page
json.total_pages @postagens.total_pages
