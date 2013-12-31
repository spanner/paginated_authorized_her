# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paginated_her/version'

Gem::Specification.new do |spec|
  spec.name          = "paginated_her"
  spec.version       = PaginatedHer::VERSION
  spec.authors       = ["William Ross"]
  spec.email         = ["will@spanner.org"]
  spec.description   = %q{Adds token auth and pagination to Her}
  spec.summary       = %q{Adds token auth and pagination to Her}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'request_store'
  spec.add_dependency 'her', "~> 0.6.8"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
