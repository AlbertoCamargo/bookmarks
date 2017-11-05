# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass', '~> 3.3.7'
gem 'coffee-rails', '~> 4.2'
gem 'google_url_shortener'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.6'
gem 'rubocop', '~> 0.51.0'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_bot_rails', '~> 4.0'
  gem 'rspec-rails', '~> 3.6'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
