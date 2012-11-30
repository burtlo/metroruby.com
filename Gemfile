source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'thin'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'blueprint-rails'
  gem 'compass-rails'
  gem 'haml-rails'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'minitar'

gem 'resque', require: 'resque/server'

gem 'aws-sdk', '~> 1.3.4'

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent'
end