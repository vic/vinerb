# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vinerb/version'

Gem::Specification.new do |spec|
  spec.name          = "vinerb"
  spec.version       = Vinerb::VERSION
  spec.authors       = ["Victor Borja"]
  spec.email         = ["vborja@apache.org"]
  spec.description   = %q{Full featured Vine API client for ruby}
  spec.summary       = %q{Full featured Vine API client for ruby}
  spec.homepage      = "http://github.com/vic/vinerb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"

  spec.add_dependency 'rest-client'
  spec.add_dependency 'multi_json'

end
