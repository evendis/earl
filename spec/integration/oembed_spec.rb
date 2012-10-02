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
    describe "#metadata" do
      subject { instance.metadata }
      it { subject[:base_url].should match(/google/) }
      it { subject[:content_type].should eql("text/html") }
      it { subject[:html].should be_nil }
    end
  end

  context "when page supports oembed" do
    let(:url) { 'http://www.youtube.com/watch?v=g3DCEcSlfhw' }
    let(:expected_oembed_html) { %(<iframe width="420" height="315" src="http://www.youtube.com/embed/g3DCEcSlfhw?fs=1&feature=oembed" frameborder="0" allowfullscreen></iframe>) }

    its(:oembed) { should be_a(Hash) }
    its(:oembed_html) { should eql(expected_oembed_html) }
    describe "#metadata" do
      subject { instance.metadata }
      it { subject[:base_url].should eql("http://www.youtube.com/watch?v=g3DCEcSlfhw") }
      it { subject[:content_type].should eql("text/html") }
      it { subject[:title].should eql("'Virtuosos of Guitar 2008' festival, Moscow. Marcin Dylla") }
      it { subject[:html].should eql(expected_oembed_html) }
    end
  end

end