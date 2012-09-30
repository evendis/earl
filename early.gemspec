# -*- encoding: utf-8 -*-
require File.expand_path('../lib/early/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["teejayvanslyke", "Paul Gallagher"]
  gem.email         = ["tj@elctech.com", "gallagher.paul@gmail.com"]
  gem.description   = %q{URL metadata API}
  gem.summary       = %q{URL metadata API for scraping titles, descriptions, images, and videos from URL's}
  gem.homepage      = "https://github.com/evendis/early"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "early"
  gem.require_paths = ["lib"]
  gem.version       = Early::VERSION

  gem.add_runtime_dependency(%q<nokogiri>, [">= 1.4.4"])
  gem.add_development_dependency(%q<bundler>, ["> 1.1.0"])
  gem.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
  gem.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
  gem.add_development_dependency(%q<rdoc>, ["~> 3.11"])
  gem.add_development_dependency(%q<guard-rspec>, ["~> 1.2.0"])
  gem.add_development_dependency(%q<rb-fsevent>, ["~> 0.9.1"])

end
