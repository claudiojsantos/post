FactoryBot.define do
  factory :comentario do
    nome { Faker::Name.name }
    comentario { Faker::Lorem.sentence }
    postagem
  end
end
