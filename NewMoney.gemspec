# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'NewMoney/version'

Gem::Specification.new do |spec|
  spec.name          = "NewMoney"
  spec.version       = NewMoney::VERSION
  spec.authors       = ["M.Ravi"]
  spec.email         = ["mondi.ravi@gmail.com"]

  spec.summary       = %q{A simple money data type implementation. Allows creation, arithmetic operations, comparisons, conversions amongs different currencies.}
  spec.description   = %q{A simple money data type implementation. Allows creation, arithmetic operations, comparisons, conversions amongs different currencies.}
  spec.homepage      = " https://github.com/pcoder/NewMoney.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
