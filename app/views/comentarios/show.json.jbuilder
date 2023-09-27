json.comentario do
  json.array! @comentario do |comentario|
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

json.current_page @comentario.current_page
json.total_pages @comentario.total_pages
