source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.1.6'
gem 'haml-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'autoprefixer-rails' # recommended by bootstrap-saas
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder'

gem 'devise' # For active admin & auth
gem 'friendly_id', '~> 5.0.0' # For nice url slugs
gem 'activeadmin', github: 'gregbell/active_admin' # Basic admin panel
gem 'cancancan' # for access control
gem 'acts_as_votable', github: 'ryanto/acts_as_votable' # for voting on links

gem 'activerecord_any_of'

# Various APIs
gem 'gibbon' # For mailchimp integration
gem 'gravatar_image_tag' # For user images
gem 'recaptcha', require: 'recaptcha/rails' # Add captcha to contact forms
gem 'geocoder' # To geolocate groups
gem 'gmaps4rails' # To make a pretty map of the groups
gem 'rmeetup', :git => 'git://github.com/pbajaria/rmeetup.git' # to talk to meetup's api

# Developer tools
gem 'activevalidators' # some easier validation
gem 'figaro' # Config env variables with config/application.yml using config/application.yml.example
gem 'heroku_san' # Deploy scripst for heroku
gem 'newrelic_rpm' # Basic error notifications and dev metrics

group :development do
  gem 'sqlite3', '1.3.8'
  gem 'quiet_assets'
end

group :development, :test do
  gem "factory_girl_rails", "~> 4.0"
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', require: false
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg'
  gem 'rails_12factor', '0.0.2'
end