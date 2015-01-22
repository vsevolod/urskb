source 'https://rubygems.org'
source 'http://rails-assets.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlserver as the database for Active Record
gem 'tiny_tds', platforms: [:mingw, :mswin]
gem 'ruby-odbc', platforms: [:mingw, :mswin]

gem 'activerecord-sqlserver-adapter', github: 'rails-sqlserver/activerecord-sqlserver-adapter', platforms: [:mingw, :mswin]
gem 'pg', platforms: [:ruby]

gem 'active_model_serializers', '~> 0.8.0'
gem 'squeel', github: 'danielrhodes/squeel'
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',                    platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',                            group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

# ActiveRecord
gem 'ancestry'
gem 'aasm'

# Templates
gem 'haml'
gem 'slim'

# Assets
gem 'rails-assets-bootstrap'
gem 'rails-assets-underscore'
gem 'rails-assets-angular'
gem 'rails-assets-angular-bootstrap'
gem 'rails-assets-angular-ui-router'
gem 'rails-assets-angular-breadcrumb'
#gem 'rails-assets-angular-ui-router.stateHelper'

gem 'angular-rails-templates'
gem 'angularjs-rails-resource', '~> 1.1.1'

group :development, :test do
  gem 'pry'
  gem 'faker' # https://github.com/stympy/faker
  gem 'factory_girl_rails' # https://github.com/thoughtbot/factory_girl_rails
  gem 'database_cleaner'
  gem 'rspec'
  gem 'rspec-rails' # https://github.com/rspec/rspec-rails
  gem 'shoulda-matchers' # https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-callback-matchers', '~> 1.0'
  gem 'spring-commands-rspec'
  gem 'jasmine'
  gem 'jasmine-rails'
  gem 'mailcatcher'
  gem 'did_you_mean'
  gem 'rack-livereload'
end
group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'meta_request'
end
gem 'wdm' if Gem.win_platform?
