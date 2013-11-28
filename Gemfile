source 'https://rubygems.org'

ruby '2.0.0'

gem 'unicorn'
gem 'rack-canonical-host'
gem 'rails', '~> 4.0.1'
gem 'pg'

gem 'awesome_print'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'high_voltage'
gem 'jquery-rails'
gem 'sass-rails'
gem 'simple_form', '~> 3.0'
gem 'slim-rails'
gem 'turbolinks'
gem 'uglifier'

# Heroku suggests that these gems aren't necessary, but they're required to compile less assets on deploy.
gem 'therubyracer', platforms: :ruby
#gem 'libv8'#, '~> 3.11.8'

group :test, :development do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'fuubar'
  gem 'jasminerice', github: 'bradphelan/jasminerice' # Latest release still depends on haml.
  gem 'poltergeist'
  gem 'rspec-rails'
  gem 'simplecov'
  #gem 'cane'
  #gem 'capybara-email'
  #gem 'morecane'
  #gem 'quiet_assets'
  #gem 'timecop'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'growl'
  gem 'guard', '~> 2'
  gem 'guard-jasmine'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'rb-fsevent'
end
