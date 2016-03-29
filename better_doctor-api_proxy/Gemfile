source 'https://rubygems.org'
ruby '2.2.3'

# Rails / Grape
gem 'rails', github: 'rails/rails'
gem 'grape'
gem 'grape-active_model_serializers'
gem 'hashie-forbidden_attributes'

# HTTP client
gem 'rest-client', '~> 1.8'
gem 'rest-client-components', '~> 1.4'

# Rack components
gem 'rack-cache', '~> 1.5'

# Logging
gem 'logging', '~> 2.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 0.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 8.0'
  gem 'rspec-rails'
end

group :development do
  gem 'pry-rails', '~> 0.3'
  gem 'listen', '~> 3.0.5'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
