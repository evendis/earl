# frozen_string_literal: true

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/unit/#{m[1]}_spec.rb" }
end

guard :rubocop, cli: ['--display-cop-names'] do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
