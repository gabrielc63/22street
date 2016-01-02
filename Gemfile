source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.13'

# Use postgresql as the database for Active Record
gem 'pg', '0.18.3'

gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.3.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

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

gem 'will_paginate', '3.0.7'

gem 'bootstrap-will_paginate'

gem 'auto_html', '1.6.4'

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
  gem 'quiet_assets'
  #debug
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-rescue'
  gem 'awesome_print'
  gem 'hirb'
end

group :development do
  # A static analysis security vulnerability scanner for Ruby on Rails applications
  gem 'brakeman', :require => false

  # Checks for code optimization.
  gem 'rubycritic', :require => false

  # Checks for undefined routes and unreachable actions.
  gem 'traceroute'

  # Checks for query optimizations.
  gem 'bullet'

  #  Profiler for your development and production Ruby rack apps.
  gem 'rack-mini-profiler', require: false

  # Checks for code optimization.
  gem 'rails_best_practices'

  # Checks for compliance to Sandi Metz's rules for developers.
  gem 'sandi_meter'

  #  A Ruby static code analyzer, based on the community Ruby style guide.
  gem 'rubocop', require: false
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

gem 'simplecov', :require => false, :group => :test
