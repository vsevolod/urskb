source 'https://rubygems.org'
source 'http://rails-assets.org'

#======== Local version ============================ FOR MS SQL Server 2008 ===================
gem 'rails', '4.1.9'
gem 'activerecord-sqlserver-adapter', github: 'rails-sqlserver/activerecord-sqlserver-adapter', tag: '4.1.0'
#======== Development version ====================== FOR MS SQL Server 2012 ===================
#gem 'rails', '4.2.0'
#gem 'activerecord-sqlserver-adapter', github: 'rails-sqlserver/activerecord-sqlserver-adapter', ref: '5a5dd78d1749b3a5e06d691f740d9ade41707eed', platforms: [:mingw, :mswin] #, tag: '4.1.0'
#===================================================

gem 'tiny_tds', platforms: [:mingw, :mswin]
gem 'active_model_serializers', '~> 0.8.0'
#gem 'pg', platforms: [:ruby]

gem 'squeel', github: 'danielrhodes/squeel'
gem 'sass-rails', '~> 4.0.3'
#gem 'ox'
#gem 'libxml-ruby'
#gem 'gyoku' #from obj to xml
#gem 'oga'
#gem 'nokogiri'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',                    platforms: :ruby

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
gem 'rails-assets-jquery', '~> 1.9.1'
gem 'rails-assets-bootstrap'
gem 'rails-assets-respond'
gem 'rails-assets-html5shiv'
gem 'rails-assets-underscore'
gem 'rails-assets-moment'
gem 'rails-assets-angular', '~> 1.2.0'
gem 'rails-assets-angular-moment'
gem 'rails-assets-angular-bootstrap'
gem 'rails-assets-angular-ui-router'
gem 'rails-assets-angular-ui-tree'
gem 'rails-assets-angular-breadcrumb'
gem 'rails-assets-angular-bootstrap-datetimepicker'
#gem 'rails-assets-angular-ui-router.stateHelper'

gem 'angular-rails-templates'
gem 'angularjs-rails-resource', '~> 1.1.1'

group :development, :test, :staging do
  gem 'pry'
  gem 'faker' # https://github.com/stympy/faker
  gem 'factory_girl_rails' # https://github.com/thoughtbot/factory_girl_rails
  gem 'database_cleaner'
  gem 'shoulda-matchers' # https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-callback-matchers', '~> 1.0'
  gem 'jasmine'
  gem 'jasmine-rails'
  gem 'did_you_mean'
  gem 'rack-livereload'
end
#group :development, :test do
#  gem 'rspec'
#  gem 'rspec-rails' # https://github.com/rspec/rspec-rails
#  gem 'spring-commands-rspec'
#  gem 'mailcatcher'
#end
group :development, :staging do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'meta_request'
end
gem 'wdm' if Gem.win_platform?
