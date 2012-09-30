#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rspec'
require 'rspec/core/rake_task'

desc "Run all RSpec test examples"
RSpec::Core::RakeTask.new do |spec|
  spec.rspec_opts = ["-c", "-f progress"]
  spec.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "early"
  rdoc.rdoc_files.include('README*', 'lib/**/*.rb')
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r early.rb"
end