Gem::Specification.new do |gem|
  gem.name          = 'win32ole_vs_facter'
  gem.homepage      = 'https://github.com/jumanjiman/win32_vs_ole'
  gem.description   = %q{Reproduce facter failure on Linux when mocking Windows}
  gem.summary       = %q{Reproduce facter failure on Linux when mocking Windows}
  gem.license       = 'GPLv3'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.authors       = `git log --format='%aN' | sort -u`.split($/)
  gem.email         = `git log --format='%aE' | sort -u`.split($/)
  gem.require_paths = ['lib']
  gem.version       = '0.0.0' # Leave at zero

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rspec-core'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-expectations'
  gem.add_development_dependency 'rspec-mocks'
  gem.add_development_dependency 'rubocop'
  gem.add_development_dependency 'puppet'
  gem.add_development_dependency 'puppetlabs_spec_helper'
  gem.add_development_dependency 'puppet-lint'
  gem.add_development_dependency 'rspec-puppet'
  gem.add_development_dependency 'friction'

  facter_ver = ENV.key?('FACTER_VER') ? ENV['FACTER_VER'] : '~> 2.0'
  gem.add_development_dependency 'facter', facter_ver
end
