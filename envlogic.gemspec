# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
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
  spec.homepage    = 'https://karafka.io'
  spec.license     = 'MIT'

  spec.add_dependency 'dry-inflector', '~> 0.1'
  spec.required_ruby_version = '>= 2.5.0'

  if $PROGRAM_NAME.end_with?('gem')
    spec.signing_key = File.expand_path('~/.ssh/gem-private_key.pem')
  end

  spec.cert_chain    = %w[certs/mensfeld.pem]
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]
  spec.metadata      = { 'source_code_uri' => 'https://github.com/karafka/envlogic' }
end
