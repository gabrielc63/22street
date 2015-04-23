source 'https://rubygems.org'
ruby '2.1.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'

# Use postgresql as the database for Active Record
gem 'pg', '0.17.1'

gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.2.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'paperclip', '~> 4.2.1'

gem 'will_paginate', '3.0.5'

gem 'bootstrap-will_paginate'

gem "auto_html"

gem 'faker', '1.1.2'

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'shoulda-matchers'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug', '~> 3.5.1'
end

group :test do
  gem 'capybara', '2.2.1'
  gem 'factory_girl_rails', '4.4.1'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner', '~> 1.4.1'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end
