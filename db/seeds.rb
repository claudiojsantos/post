include FactoryBot::Syntax::Methods

ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Seeding database...'

author = User.find_or_create_by!(name: 'author', email: 'author@test.com') do |user|
  user.password = '12345678'
end

10.times do
  postagem = create(:postagem, user: author)

  5.times do
    create(:comentario, postagem:)
  end
end

puts 'Seeding complete!'
