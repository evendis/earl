require 'spec_helper'

# These tests hit real network endpoints - not included in the default test runs. Run with:
#  rake spec:integration
# or
#  rake spec:all
#
describe Urly do
  let(:instance) { Urly[url] }

  subject { instance }

  context "when page does not support oembed" do
    let(:url) { 'http://google.com/' }
    its(:oembed) { should be_nil }
    its(:oembed_html) { should be_nil }
  end

  context "when page supports oembed" do
    let(:url) { 'http://www.youtube.com/watch?v=g3DCEcSlfhw' }
    its(:oembed) { should be_a(Hash) }
    its(:oembed_html) { should eql(%(<iframe width="420" height="315" src="http://www.youtube.com/embed/g3DCEcSlfhw?fs=1&feature=oembed" frameborder="0" allowfullscreen></iframe>)) }
  end

end