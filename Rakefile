require 'rubygems'
require 'rake'

require 'jeweler'
require File.expand_path('../lib/version', __FILE__)
Jeweler::Tasks.new do |gem|
  gem.name = "kronos"
  gem.version = Kronos::Version::STRING
  gem.summary = %Q{Simple and flexible date parsing.}
  gem.description = %Q{Kronos provides flexible date parsing. Currently just a thin layer on top of ParseDate.}
  gem.email = "djames@sunlightfoundation.com"
  gem.homepage = "http://github.com/djsun/kronos"
  gem.authors = ["David James"]
  gem.add_development_dependency "rspec", "~> 2.2"
  gem.rubyforge_project = 'kronos'
  # gem is a Gem::Specification
  # see http://www.rubygems.org/read/chapter/20 for additional settings
end

require 'rspec/core/rake_task'
desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w(--color)
  # t.rspec_opts = %w(-fs --color)
  # t.ruby_opts  = %w(-w)
end
