$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "haystack/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "haystack"
  s.version     = Haystack::VERSION
  s.authors     = ["Aaron Magil"]
  s.email       = ["amagil@camsys.com"]
  s.homepage    = "http://www.camsys.com"
  s.summary     = "A Simple Searcher based on work in TransAM."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"
  s.add_dependency 'haml-rails'
  s.add_dependency 'simple_form'

  s.add_development_dependency "sqlite3"
end
