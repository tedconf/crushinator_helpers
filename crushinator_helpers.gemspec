$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "crushinator_helpers/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "crushinator_helpers"
  s.version     = CrushinatorHelpers::VERSION
  s.authors     = ["Alex Dean"]
  s.email       = ["alex@crackpot.org"]
  s.homepage    = "https://github.com/tedconf/crushinator_helpers"
  s.summary     = "view helpers for using crushinator"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = 'https://rubygems.ted.com/private'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  s.add_dependency 'rails', '>= 4.0'
  s.add_development_dependency 'bundler', '> 2.0'
  s.add_development_dependency "brakeman"
  s.add_development_dependency "bundler-audit"
  s.add_development_dependency "rubocop-checkstyle_formatter"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "ruby_gntp"
  s.add_development_dependency "ci_reporter_rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "simplecov-rcov"
  s.add_development_dependency "terminal-notifier-guard"
end
