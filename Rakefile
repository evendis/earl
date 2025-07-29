#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rspec'
require 'rspec/core/rake_task'

desc "Run only unit test examples"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'spec/unit/**/*_spec.rb'
end

desc "Run only integration test examples"
RSpec::Core::RakeTask.new(:'spec:integration') do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'spec/integration/**/*_spec.rb'
end

desc "Run all test examples including integration tests"
RSpec::Core::RakeTask.new(:'spec:all') do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'spec/**/*_spec.rb'
end

task default: :spec

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -I lib -r earl.rb"
end
