source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '3.0.1'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem "jquery-ui-rails"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# New Relic addon for Heroku ping
gem 'newrelic_rpm'

# Simpel forms for input fomrs
gem 'simple_form', '~> 3.0.0.rc'

# Secure Passwords with
gem 'bcrypt-ruby', '3.0.1'

# For adding example data
gem 'faker', '1.1.2'

# For pagination
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'

# Twitter Bootstrap integration
gem 'bootstrap-sass', '2.3.2.0'
# gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
#                           :github => 'anjlab/bootstrap-rails',
#                           :branch => '3.0.0'
                          
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use sqlite3 as the database for Active Record
group :development, :test do
	gem 'sqlite3', '1.3.8'
	gem 'rspec-rails', '2.13.1'
end

group :test do
  gem 'selenium-webdriver', '2.0.0'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
end

# User postgres for production
group :production do
	gem 'pg', '0.15.1'
	gem 'rails_12factor', '0.0.2' # Vor visiting logs in heroku
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]