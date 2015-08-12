# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'confirmed_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "confirmed_attributes"
  spec.version       = ConfirmedAttributes::VERSION
  spec.authors       = ["Alexander Shlinchak"]
  spec.email         = ["ashlinchak@gmail.com"]

  spec.summary       = %q{Confirmable attributes for ActiveRecord}
  spec.description   = %q{Adds functionality confirmable attributes to models.}
  spec.homepage      = "https://github.com/ashlinchak/confirmed_attributes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency "sqlite3", "~> 1.3.10"
  spec.add_development_dependency "activerecord", "~> 4.2.3"
end
