source 'https://rubygems.org'

# Use dotenv to read environment variables from .env file
gem 'dotenv-rails', '~> 2.0', '>= 2.0.2', :groups => [:development, :test]
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# use postgresql as database
gem 'pg', '~> 0.18.3'

# use puma as application server
gem 'puma', '~> 2.13.4'

# api gem
gem 'active_model_serializers', '~> 0.8.3'
gem 'devise', '~> 3.5', '>= 3.5.3'

group :development, :test do
  gem 'minitest-reporters', '~> 1.1.0'
  gem 'rspec-rails', '~> 3.4'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'ffaker', '~> 2.1'
  gem 'shoulda-matchers', '~> 3.0', '>= 3.0.1'
end

group :development do
  gem 'byebug', '~> 8.2', '>= 8.2.1'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Guard
  gem 'guard', '~> 2.13.0'
  # Automatically & intelligently launch tests with the minitest framework when
  # files are modified:
  gem 'guard-minitest', '~> 2.4.4'
  gem 'guard-livereload', '~> 2.5', '>= 2.5.1'
end

group :production do
  # heroku 12factor application
  gem 'rails_12factor', '~> 0.0.3'
end
