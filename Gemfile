source 'https://rubygems.org'

ruby '4.0.6'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
# Serves the legacy Materialize/Sprockets pipeline (JS/CSS/images) that still
# coexists with Tailwind/importmap until every page migrates. Previously
# pulled in transitively by sass-rails; now needed explicitly.
gem 'sprockets-rails'
# Compile SCSS via the Dart Sass CLI (no Ruby-language Sass implementation involved)
gem 'dartsass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Hotwire: SPA-like page updates without writing custom JavaScript (replaces Turbolinks)
gem 'turbo-rails'
# Hotwire: modest JavaScript framework for the HTML you already have (replaces jQuery/Cocoon JS)
gem 'stimulus-rails'
# Manage JavaScript with ESM import maps, no Node/bundler required (replaces jquery-rails' asset)
gem 'importmap-rails'
# Tailwind CSS, compiled via standalone CLI (no Node required)
gem 'tailwindcss-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Paginate. Rendering is now TailwindPaginationRenderer (app/helpers) instead
# of will_paginate-materialize, which force-overrides the renderer via a
# will_paginate monkeypatch that ignores WillPaginate::ViewHelpers.pagination_options
# -- and its own renderer crashes under the current will_paginate/Ruby combo
# once a collection actually spans more than one page.
gem 'will_paginate'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'capybara', '~> 3.40'
  gem 'selenium-webdriver', '~> 4.0'
  # No longer a default gem bundled with the Ruby install; capybara requires it directly.
  gem 'matrix'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# No longer a default gem bundled with the Ruby install; rake requires it directly.
gem 'ostruct'

# Materialize Sass version for Rails Asset Pipeline
#gem 'materialize-sass'
#gem 'material_icons'

#Flexible authentication solution for Rails
gem 'devise'

#Create beautiful JavaScript charts with one line of Ruby https://chartkick.com
gem "chartkick", "3.4.2"

gem 'dotenv-rails', groups: [:development, :test]
