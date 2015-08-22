$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "haystack/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "haystack"
  s.version     = Haystack::VERSION
  s.authors     = ["Aaron Magil", "Liz Morrison"]
  s.email       = ["abmagil@gmail.com"]
  s.homepage    = "https://github.com/abmagil/haystack"
  s.summary     = "A Simple Searcher"
  s.description = "Haystack is based on work by Julian Ray and Aaron Magil for Cambridge Systematics TransAM."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.0"

end
