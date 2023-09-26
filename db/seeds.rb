ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Seeding database...'
User.find_or_create_by!(name: 'admin', email: 'admin@test.com') do |user|
  user.password = '12345678'
end
puts 'Seeding complete!'
