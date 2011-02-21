Gem::Specification.new do |s|
  s.name        = "j"
  s.version     = "0.5.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Akash Manohar"]
  s.email       = ["akash@akash.im"]
  s.homepage    = "http://akash.im/j"
  s.summary     = "j task manager - v" + s.version.to_s
  s.description = %q{j, stands for jot and is a simple command-line task manager. Inspired by t- task manager which is written in python}
  
  s.add_dependency "rainbow", "~> 1.1.1"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
