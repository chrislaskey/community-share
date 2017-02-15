source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.1"
gem "dotenv-rails", require: "dotenv/rails-now"
gem "pg"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "jquery-rails"
gem "devise"
gem "omniauth-facebook"
gem "paperclip", "~> 5.0.0"
gem "aws-sdk", "~> 2.0"
gem "will_paginate", "~> 3.1.0"

group :development, :test do
  gem "puma", "~> 3.0"
  gem "byebug", platform: :mri
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "pry-rails"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "rubocop", require: false
end

group :production do
  gem "unicorn"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
