source 'https://rubygems.org'

ruby '2.0.0'

## Framework
gem 'high_voltage'
gem 'newrelic_rpm'
gem 'pg'
gem 'rack-canonical-host'
gem 'rails', '~> 4.0.4'
gem 'rollbar'
gem 'simple_form', '~> 3.0'
# Heroku suggests that these gems aren't necessary, but they're required to compile less assets on deploy.
gem 'therubyracer', platforms: :ruby
gem 'unicorn'

## Asset Pipeline
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'font-awesome-rails'
gem 'sass-rails', '~> 4.0.2'

gem 'slim', '2.0.0' # Pinned due to tilt dependency conflict
gem 'slim-rails', '~> 2.1.3'
gem 'uglifier'

## Authentication
gem 'omniauth'
gem 'omniauth-facebook'

## Frontend
gem 'backbone-rails'
gem 'jquery-rails'
gem 'marionette-rails'
gem 'underscore-rails'

group :test, :development do
  gem 'awesome_print'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'fuubar'
  gem 'jasmine-rails'
  gem 'poltergeist'
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'rspec-rails'
  gem 'timecop'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard', '~> 2'
  gem 'guard-jasmine'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'launchy'
  gem 'rb-fsevent'
end
