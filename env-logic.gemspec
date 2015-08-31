lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake'
require 'env_logic/version'

Gem::Specification.new do |spec|
  spec.name          = "env-logic"
  spec.platform      = Gem::Platform::RUBY
  spec.version       = EnvLogic::VERSION
  spec.authors       = ["pavlo_vavruk"]
  spec.email         = ["pavlo.vavruk@gmail.com"]

  spec.summary       = %q{}
  spec.description   = %q{}
  spec.homepage      = ""

  spec.add_dependency 'activesupport'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w( lib )
end
