source 'https://rubygems.org'
ruby '2.4.1'

gem 'bootstrap-sass', '3.1.1.1'
gem 'bootstrap_form'
gem 'coffee-rails'
gem 'rails' # , '4.1.14.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'eventmachine', :platforms => [:ruby, :x64_mingw]
gem 'tzinfo-data'
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt', platforms: [:x64_mingw, :mingw]

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '3.7.2'#, '2.99'
  gem 'hirb'
end

group :test do
  gem 'database_cleaner', '1.4.1'
  gem 'shoulda-matchers', '2.7.0'
  gem 'vcr', '2.9.3'
  gem 'rails-controller-testing'
  gem 'fabrication'
  gem 'faker'
end

group :production do
  gem 'rails_12factor'
end

