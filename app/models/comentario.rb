class Comentario < ApplicationRecord
  belongs_to :postagem

  validates :nome, presence: true, length: { minimum: 5 }
  validates :comentario, presence: true, length: { minimum: 10 }
end
