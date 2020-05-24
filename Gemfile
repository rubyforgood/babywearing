# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3.3'
gem 'rails', '~> 6.0.2.2'
gem 'sassc', '2.3.0'
gem 'sassc-rails', '~> 2.1' # Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

gem 'aasm'
gem 'acts_as_tenant'
gem 'aws-sdk-s3'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.4.1'
gem 'bootstrap-table-rails'
gem 'filterrific'
gem 'font-awesome-rails'
gem 'jbuilder', '~> 2.10.0'
gem 'jquery-rails'
gem 'mina'
gem 'mina-puma', require: false
gem 'mini_magick', '~> 4.8'
gem 'money-rails', '~>1.12'
gem 'name_of_person'
gem 'responders'
gem 'turbolinks', '~> 5'
gem 'whenever', require: false
gem 'will_paginate'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pivotal_git_scripts'
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
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'devise', '>= 4.7.1'
gem 'pundit'
gem 'rubocop'
gem 'rubocop-rspec'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
