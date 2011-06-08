# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "page_models/version"

Gem::Specification.new do |s|
  s.name        = "pagemodels"
  s.version     = PageModels::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rick Grundy"]
  s.email       = ["rick@rickgrundy.com"]
  s.homepage    = "http://www.githup.com/rickgrundy/pagemodels"
  s.summary     = "Page models for your browser driving acceptance tests with optional integration for RSpec, Cucumber, and Rails."
  s.description = "See http://www.githup.com/rickgrundy/pagemodels"

  s.rubyforge_project = "pagemodels"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency 'rspec', '>= 2.5.0'
end
