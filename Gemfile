source 'https://rubygems.org'
#ruby '2.1.2'
ruby '2.1.5'

gem 'rails', '4.1.0'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development

gem 'therubyracer',  platforms: :ruby
gem 'bcrypt', '~> 3.1.7'
gem 'nokogiri', '~> 1.6.1'
gem 'rails-i18n', '~> 4.0.1'
gem 'foreigner', '~> 1.6.1'
gem 'kaminari', '~> 0.15.1'
gem 'date_validator', '~> 0.7.0'
gem 'email_validator', '~> 1.4.0'
gem 'jquery-ui-rails', '~> 4.2.1'
gem 'quiet_assets', '~> 1.0.2', group: :development
group :test do
  gem 'rspec-rails', '~> 3.0.0.beta2'
  gem 'spring-commands-rspec', '~> 1.0.1'
  gem 'capybara', '~> 2.2.1'
  gem 'factory_girl_rails', '~> 4.4.1'
end

# http://qiita.com/SanoHiroshi/items/d7942d66678f0d60f0ed
#group :production, :staging do 
  gem 'unicorn'
#end
#group :development do 
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-rbenv', '~> 2.0', require: false
  #gem 'capistrano-rbenv', require: false
  gem 'capistrano3-unicorn'
  gem 'capistrano-rails-console' # 手元の環境からデプロイ先のconsoleを使う
#end

group :development do 
  gem 'pry-byebug'
end
