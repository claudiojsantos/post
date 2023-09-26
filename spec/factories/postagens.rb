FactoryBot.define do
  factory :postagem do
    titulo { Faker::Book.title }
    texto { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    user
  end
end
