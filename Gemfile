source 'https://rubygems.org'
ruby '2.2.4'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
gem 'bootstrap-sass', '~> 3.3.6'
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

gem 'devise', '~> 3.5', '>= 3.5.6'
gem 'haml', '~> 4.0', '>= 4.0.7'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Unicorn as the app server
# gem 'unicorn'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Preview email in the default browser instead of sending it.
  # This means you do not need to set up email delivery in your development environment
  gem 'letter_opener'
  gem 'thin'# web server
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
end

group :test do
  gem 'factory_girl_rails', '~> 4.7'
  gem 'capybara', '~> 2.7'
  gem 'guard-rspec', '~> 4.6', '>= 4.6.5'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

## mongoid and related --------------------------------------------------------------
gem 'mongoid', "~> 5.0.0"#'~> 5.1', '>= 5.1.2'
gem 'mongoid_token', '~> 4.0.0'
gem "doorkeeper-mongodb", github: "doorkeeper-gem/doorkeeper-mongodb"
# soft delete documents
gem 'mongoid_paranoia'

## file uploads ---------------------------------------------------------------------
gem 'fog'
gem 'mini_magick'#process image versions in background
gem 'carrierwave-mongoid', '~> 0.8.1'
gem 'carrierwave_backgrounder', '~> 0.4.2'
# Simple gem for copying CarrierWave files between resources.
# It's solving issues with local and remote storage discussed here
gem 'copy_carrierwave_file'

## Jquery related --------------------------------------------------------------------
gem 'jquery-turbolinks'
gem 'cocoon' # nested attributed fields setup
# Fast, light and responsive lightbox plugin, for jQuery
gem 'magnific-popup-rails', '~> 1.1.0'
#iCheck is a library for creating super customized checkboxes and radio buttons with JQuery
gem 'icheck-rails'

## other assets related ----------------------------------------------------------------
gem "font-awesome-rails"
gem "font-ionicons-rails"

## Authorization -----------------------------------------------------------------------
gem 'cancancan'

## OmniAuth ----------------------------------------------------------------------------
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'

## others ------------------------------------------------------------------------------
gem 'active_link_to'
gem 'faker' # generates fake data