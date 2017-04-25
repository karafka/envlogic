# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'envlogic/version'

Gem::Specification.new do |spec|
  spec.name        = 'envlogic'
  spec.platform    = Gem::Platform::RUBY
  spec.version     = Envlogic::VERSION
  spec.authors     = ['pavlo_vavruk', 'Maciej Mensfeld']
  spec.email       = %w[pavlo.vavruk@gmail.com maciej@mensfeld.pl]
  spec.summary     = 'Library which allows to set and get environments values'
  spec.description = 'Library used to manage environments for your Ruby application'
  spec.homepage    = 'https://github.com/karafka/envlogic'

  spec.add_dependency 'activesupport'
  spec.required_ruby_version = '>= 2.2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]
end
