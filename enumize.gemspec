# frozen_string_literal: true

$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "enumize/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "enumize"
  spec.version     = Enumize::VERSION
  spec.authors     = ["Jason Lee"]
  spec.email       = ["huacnlee@gmail.com"]
  spec.homepage    = "https://github.com/huacnlee/enumize"
  spec.summary     = "Extend ActiveRecord::Enum for add more helpful methods."
  spec.description = "Extend ActiveRecord::Enum for add more helpful methods"

  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.0.0"

  spec.add_development_dependency "mysql2"
end
