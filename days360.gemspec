# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'days360/version'

Gem::Specification.new do |spec|
  spec.name          = "days360"
  spec.version       = Days360::VERSION
  spec.authors       = ["Michael Prilop"]
  spec.email         = ["Michael.Prilop@gmail.com"]
  spec.description   = %q{Calculates the difference between two dates based on the 360 day year used in interest calculations}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
end
