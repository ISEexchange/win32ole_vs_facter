require 'minitest'
require 'mocha/setup'
require 'rspec-puppet'
require 'English'
require 'puppetlabs_spec_helper/puppetlabs_spec_helper'

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
    # We only run tests on Linux, so put a nail in win32ole loaderr.
    Facter::Util::Config.stubs(:is_windows?).returns false

    # don't cache facts between test cases
    Facter::Util::Loader.any_instance.stubs(:load_all)
    Facter.clear unless ENV.key?('PRESERVE')
    Facter.clear_messages

    # Store any environment variables away to be restored later
    @old_env = {}
    ENV.each_key { |k| @old_env[k] = ENV[k] }
  end

  c.after :each do
    # Restore environment variables after execution of each test
    @old_env.each_pair { |k, v| ENV[k] = v }
    to_remove = ENV.keys.reject { |key| @old_env.include? key }
    to_remove.each { |key| ENV.delete key }
  end
end
