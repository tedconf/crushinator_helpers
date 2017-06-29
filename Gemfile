source "https://rubygems.org"

# Declare your gem's dependencies in crushinator_helpers.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
gem 'pry'

# don't release to rubygems when doing 'rake release'
ENV['gem_push'] = 'no'

group :development do
  gem 'brakeman', '~> 3.4.0', require: false
  gem 'bundler-audit', '~> 0.5.0'
  gem 'rubocop-checkstyle_formatter', '~> 0.3.0'
  gem 'simplecov', '~> 0.12.0', require: false
  gem 'simplecov-rcov', require: false
  gem 'terminal-notifier-guard', '~> 1.6.0'
end
