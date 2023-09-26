class Postagem < ApplicationRecord
  belongs_to :user
  has_many :comentarios, dependent: :destroy

  validates :titulo, presence: true, length: { minimum: 10 }
  validates :texto, presence: true, length: { minimum: 10 }
end
