# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smartcoin/version'

Gem::Specification.new do |spec|
  spec.name          = "smartcoin"
  spec.version       = Smartcoin::VERSION
  spec.authors       = ["Arthur Granado"]
  spec.email         = ["agranado@smartcoin.com.br"]
  spec.summary       = %q{Ruby bind to SmartCoin API}
  spec.description   = %q{Ruby library to SmartCoin API - https://smartcoin.com.br}
  spec.homepage      = "https://smartcoin.com.br"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.6.7"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.0"
end
