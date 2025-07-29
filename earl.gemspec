# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'earl/version'

Gem::Specification.new do |gem|
  gem.authors       = ["teejayvanslyke", "Paul Gallagher"]
  gem.email         = ["tj@elctech.com", "gallagher.paul@gmail.com"]
  gem.description   = 'URL metadata API'
  gem.summary       = 'URL metadata API for scraping titles, descriptions, images, and videos from URLs'
  gem.homepage      = 'https://github.com/evendis/earl'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'earl'
  gem.require_paths = ["lib"]
  gem.version       = Earl::VERSION
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 3.0'
  gem.add_runtime_dependency 'nokogiri', '~> 1.18'
  gem.add_runtime_dependency 'oembedr', '>= 1.0.0'
end
