
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "openapi2ruby/version"

Gem::Specification.new do |spec|
  spec.name          = "openapi2ruby"
  spec.version       = Openapi2ruby::VERSION
  spec.authors       = ["takanamito"]
  spec.email         = ["takanamito0928@gmail.com"]

  spec.summary       = %q{A simple ruby class generator from OpenAPI schema}
  spec.description   = %q{A simple ruby class generator from OpenAPI schema}
  spec.homepage      = "https://github.com/takanamito/openapi2ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '~> 2.3'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'thor', '>= 0.20', '< 2.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
