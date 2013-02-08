source 'http://rubygems.org'

gem 'rails', '3.2.11'
gem 'mysql2'
gem 'databasedotcom'
gem 'databasedotcom-rails'
gem 'heroku'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer', :platforms => :ruby
end

gem 'jquery-rails'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3' # you will need this too
  gem 'pg'
end
