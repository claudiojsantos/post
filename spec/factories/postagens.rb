FactoryBot.define do
  factory :postagem do
    titulo { Faker::Book.title.length < 10 ? Faker::Book.title + Faker::Book.title : Faker::Book.title }
    texto { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    user
  end
end
