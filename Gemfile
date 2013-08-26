source 'https://rubygems.org'
#ruby '2.0.0'

gem 'rails', '3.2.13'

group :assets do
  gem 'sass'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'haml_coffee_assets'#, '~> 1.1.3'
  gem 'execjs'
  gem 'uglifier', '>= 1.0.3'
  # gem 'less'
  gem 'jquery-ui-rails'
  gem 'bootstrap-kaminari-views'
end

group :test, :development do 
  gem 'rspec-rails', "~> 2.6" 
  gem "factory_girl_rails"
  gem "dotenv", "~> 0.8.0"
  # gem 'sqlite3'
  # gem 'cucumber'
  # gem 'shoulda-matchers'
  # gem 'resque_spec'
end

group :development do
  gem 'railroady' # erd generation (http://railroady.prestonlee.com/) # rake diagram:all
  gem "better_errors"
  gem "binding_of_caller"
  gem 'annotate', ">=2.5.0"
  gem 'foreman'
  gem 'rails-dev-tweaks', '~> 0.6.1'
  # gem 'awesome_print'
  # gem 'bumbler'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'spork'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spork'
  
end

group :production do
  gem 'newrelic_rpm'
end

# server
gem 'thin'

# database
gem 'pg'
gem 'ar-tsvectors', :require => 'activerecord_tsvectors'

# background tasks
gem 'delayed_job_active_record'
gem "delayed_job_web"


# parsing
gem 'nokogiri'
gem 'fastercsv'
gem 'json', '>= 1.7.7'

# views / front end
gem 'rabl'
gem 'yajl-ruby'
gem 'jquery-rails'
gem 'haml-rails'
gem 'backbone-on-rails'
gem 'skeleton-rails'
gem 'stamp'
gem 'backbone-support'
gem 'sass-rails' # if running rails 3.1 or greater
gem 'compass-rails'
gem 'simple_form'
gem 'phone', :git => 'https://github.com/carr/phone.git'
gem 'draper', '~> 1.0'
gem 'acts-as-taggable-on', '~> 2.3.1'
gem 'jquery-datatables-rails'
gem 'jquery-ui-rails'
gem 'ckeditor'
gem 'render_anywhere', :require => false
gem 'multi_fetch_fragments'

# messaging
# gem 'pusher'
gem 'dalli'

# key value store
gem 'redis'
gem 'devise', '~> 2.1.2'

# models 
gem 'state_machine', :require => 'state_machine'
gem 'paperclip', :require => 'paperclip'
gem 'aws-sdk', '~> 1.3.4'
gem 'aws-s3'
gem 'activemerchant'
gem 'paper_trail', :git => 'https://github.com/airblade/paper_trail.git'
gem 'inherited_resources'
gem 'has_scope'
gem "friendly_id", "~> 4.0.1"
gem "squeel"
gem 'forgery' 
gem 'codemirror-rails'
gem 'time_zone_ext'
gem 'kaminari' # pagination
gem 'deep_cloneable'

# http
gem "typhoeus"