# vim: set ts=2 sw=2 ai et:

begin
  require 'bundler/setup'
rescue
  require 'rubygems' # support older distros
  require 'bundler/setup'
end

require 'puppetlabs_spec_helper/rake_tasks'

require 'rubocop/rake_task'
Rubocop::RakeTask.new

task :default do
  Rake::Task[:help].invoke
end
