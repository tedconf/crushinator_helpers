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

  s.add_dependency 'rails', '>= 4.0'

  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "ruby_gntp"
  s.add_development_dependency "ci_reporter_rspec"
  s.add_development_dependency "thor"
end
