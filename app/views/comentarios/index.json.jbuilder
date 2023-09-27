json.comentarios do
  json.array! @comentarios do |comentario|
    json.id comentario.id.to_s
    json.comentado_por comentario.nome
    json.data comentario.created_at
    json.comentario comentario.comentario

    json.postagem do
      json.id comentario.postagem.id.to_s
      json.titulo comentario.postagem.titulo
    end
  end
end

json.current_page @comentarios.current_page
json.total_pages @comentarios.total_pages
