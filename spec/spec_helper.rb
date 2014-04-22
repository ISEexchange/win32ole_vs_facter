require 'minitest'
require 'mocha/setup'
require 'rspec-puppet'
require 'English'

RSpec.configure do |c|
  c.mock_with 'mocha'
  c.fail_fast = false
  c.color = true
  c.formatter = 'doc'

  # == rspec-puppet options ==
  fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')

  c.before :each do
    # don't cache facts between test cases
    Facter::Util::Loader.any_instance.stubs(:load_all)
    Facter.clear unless ENV.key?('PRESERVE')
    Facter.clear_messages
  end
end
