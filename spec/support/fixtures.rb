# frozen_string_literal: true

module FixtureHelper
  def fixture_path(name)
    File.dirname(__FILE__) + "/../fixtures/#{name}.html"
  end

  def fixture(name)
    File.new(fixture_path(name)).read
  end
end

RSpec.configure do |conf|
  conf.include FixtureHelper
end
