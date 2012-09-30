module FixtureHelper
  def fixture(name)
    File.dirname(__FILE__) + "/../fixtures/#{name}.html"
  end
end

RSpec.configure do |conf|
  conf.include FixtureHelper
end