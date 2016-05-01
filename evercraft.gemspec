# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'evercraft/version'

Gem::Specification.new do |spec|
  spec.name          = 'evercraft'
  spec.version       = Evercraft::VERSION
  spec.authors       = ['Chris']
  spec.email         = ['ignatz@gmail.com']

  spec.summary       = 'Evercraft Kata in Ruby'
  spec.description   = 'Demonstration of Test Improvisation'
  spec.homepage      = 'https://github.com/folkengine/evercraft_ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
end
