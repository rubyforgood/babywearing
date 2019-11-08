# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.1' # Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# For font-awesome icons
gem "font-awesome-rails"

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'filterrific'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'name_of_person'
gem 'rolify'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Adding bootstrap, using this walkthrough: https://github.com/twbs/bootstrap-rubygem#a-ruby-on-rails
gem 'bootstrap', '~> 4.3.1'

# Adding jQuery, using this walkthrough: https://github.com/twbs/bootstrap-rubygem#a-ruby-on-rails
gem 'jquery-rails'

gem 'aws-sdk-s3'

# Used for application modals
gem "responders"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails', '~> 5.0'
  gem 'rspec-rails', '~> 3.8'
  # add simpleCov for Code Climate test coverage visibility
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'devise', '>= 4.7.1'
gem 'pundit'
gem 'rubocop'
gem 'rubocop-rspec'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
