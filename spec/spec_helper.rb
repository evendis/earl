require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'earl'

Spec::Runner.configure do |config|
  
end

def fixture(name)
  File.dirname(__FILE__) + "/fixtures/#{name}.html"
end
