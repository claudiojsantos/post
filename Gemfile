source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.8'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt'

# jwt
gem 'jwt'

# Paginador
gem 'kaminari'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'byebug', '~> 11.1', '>= 11.1.3'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker', '~> 3.1', '>= 3.1.1'
  gem 'pry-byebug', '~> 3.10', '>= 3.10.1'
  gem 'rails-controller-testing'
  gem 'rspec', '~> 3.12'
  gem 'rspec-expectations', '~> 3.12', '>= 3.12.2'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
end

group :development do
  gem 'annotate'
  gem 'rubocop', '~> 1.46'
  gem 'rubocop-performance', '~> 1.16'
  gem 'rubocop-rails', '~> 2.18'
  gem 'rubocop-rspec', '~> 2.18', '>= 2.18.1'
  gem 'spring'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
end
