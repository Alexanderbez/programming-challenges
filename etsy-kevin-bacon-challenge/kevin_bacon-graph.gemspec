# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kevin_bacon/graph/version'

Gem::Specification.new do |spec|
  spec.name        = 'kevin_bacon-graph'
  spec.version     = KevinBacon::Graph::VERSION
  spec.authors     = ['Alex Bezobchuk']
  spec.email       = ['abezobchuk@gmail.com']
  spec.summary     = %q{Solution to the Etsy Kevin Bacon homework challenge.}
  spec.description = %q{Solution to the Etsy Kevin Bacon homework challenge.}
  spec.license     = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ''
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5'
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'minitest-reporters', '~> 1'
end
