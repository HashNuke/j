# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "t/version"

Gem::Specification.new do |s|
  s.name        = "t"
  s.version     = T::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Akash Manohar"]
  s.email       = ["akash@akash.im"]
  s.homepage    = "http://akash.im"
  s.summary     = %q{a simple command-line task manager}
  s.description = %q{a simple command-line task manager. Inspired by t and t- task managers which are written in python}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
