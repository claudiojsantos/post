json.postagem do
  json.array! @postagem do |postagem|
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

json.current_page @postagem.current_page
json.total_pages @postagem.total_pages
