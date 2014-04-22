source "https://rubygems.org"
gemspec

facter_ver = ENV.key?('FACTER_VER') ? ENV['FACTER_VER'] : '~> 2.0'
if facter_ver == 'bisect'
  gem 'facter', path: './facter'
else
  gem 'facter', facter_ver
end
