source 'https://rubygems.org'

ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.4'

gem 'puma', '3.9.1'

# Use SCSS for stylesheets
gem 'sass-rails', '5.0.6'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '3.2.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '4.2.2'

# Use ActiveModel has_secure_password
gem 'bcrypt', '3.1.10'

# Use jquery as the JavaScript library
gem 'jquery-rails', '4.3.1'
gem "jquery-ui-rails", '6.0.1'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '5.0.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.7.0'

# New Relic addon for Heroku ping
#gem 'newrelic_rpm'

# Simpel forms for input fomrs
gem 'simple_form', '3.5.0'

#gem 'simple-form-datepicker', '~> 0.1.3'

# For pagination
gem 'will_paginate', '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'

# How about to use friendly url
gem "friendly_id", "5.2.3"

# Uploading images
gem "paperclip", "5.2.1"

# Amazone S3 storage
#gem 'aws-sdk', '2.2.3'
#gem 'aws-sdk', '< 2.0'
#gem 'aws-s3', '0.6.3'

# Twitter Bootstrap integration
# https://github.com/twbs/bootstrap-rubygem bootstrap 4
gem 'bootstrap', '4.0.0'
#gem 'bootstrap-sass', '3.3.7'

# Image popUp
# gem "fancybox2-rails", "0.2.9"
# We have to use this for rails 5 support
gem 'fancybox2-rails', '~> 0.3.0', github: 'ChallahuAkbar/fancybox2-rails'

gem 'state_machine', '1.2.0'

#gem 'i18n', github: 'svenfuchs/i18n'
gem 'rails-i18n', '~> 5.0.0'

gem 'random_record'

gem 'awesome_nested_fields', '0.6.4'
# hide configurations file
gem 'figaro', '1.1.1'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use sqlite3 as the database for Active Record
group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
	gem 'rspec-rails', '3.7.2'
  gem 'annotate', '2.7.2'
  # For adding example data
  gem 'faker', '1.8.7'
end

group :test do
  gem 'selenium-webdriver', '3.8.0'
  gem 'capybara', '2.17.0'
  gem 'factory_girl_rails', '4.9.0'
  gem 'zip', '2.0.2' # For Codeship
end

# User postgres for production
group :production do
	gem 'pg', '1.0.0'
	gem 'rails_12factor', '0.0.3' # Vor visiting logs in heroku
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
