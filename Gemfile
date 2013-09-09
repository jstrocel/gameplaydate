source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0.rc1'

gem 'bcrypt-ruby', '3.0.1'
gem 'bootstrap-sass', '2.3.1.0'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
gem 'faker', '1.1.2'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'rack', '1.5.2'
gem 'rails', '4.0.0.rc1'
gem 'sass-rails',   '~> 4.0.0.rc1'
gem 'coffee-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.3.0'

gem 'therubyracer'
gem 'less', '2.3.2'
gem 'less-rails', '2.3.3'
gem 'jbuilder', '1.0.2'

gem 'resque', "~> 1.22.0"
gem 'resque_mailer'

gem 'debugger'


group :development do
  gem 'annotate', '2.5.0'
  gem "nifty-generators"
end

group :development, :test do
  gem 'sqlite3', '1.3.7'
  gem 'rspec-rails', '2.13.2'
  gem 'guard-rspec', '2.5.0'
  gem 'spork-rails', github: 'railstutorial/spork-rails'
  gem 'guard-spork', :github => 'guard/guard-spork'  
  gem 'spork', '~> 1.0rc'
  gem 'factory_girl_rails', '4.2.1' 
  gem 'mocha', :require => 'mocha/api'
end

group :test do
  gem 'resque_spec'
  gem 'capybara', '2.1.0'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'database_cleaner', '1.0.1'
  gem 'launchy', '2.3.0'
  group :darwin do
    # gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
      gem 'guard-pow', :require => false
    end
  
  gem 'growl', '1.0.3'
  
end



group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor'
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end

