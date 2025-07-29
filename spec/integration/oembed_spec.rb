require 'spec_helper'

# These tests hit real network endpoints - not included in the default test runs. Run with:
#  rake spec:integration
# or
#  rake spec:all
#
describe Earl do
  subject(:instance) { Earl[url] }

  context "when page does not support oembed" do
    let(:url) { 'https://github.com/evendis/earl' }
    it { expect(subject.oembed).to eql({error: 'no matching providers found', url: 'https://github.com/evendis/earl'}) }
    it { expect(subject.oembed_html).to be_nil }
    describe "#metadata" do
      subject { instance.metadata }
      it { expect(subject[:base_url]).to match(/github\.com\/evendis\/earl/) }
      it { expect(subject[:content_type]).to eql("text/html") }
      it { expect(subject[:html]).to be_nil }
    end
  end

  # context "when page supports oembed" do
  #   let(:url) { 'https://www.youtube.com/watch?v=g3DCEcSlfhw' }
  #   let(:expected_oembed_html) { %(<iframe width="420" height="315" src="http://www.youtube.com/embed/g3DCEcSlfhw?fs=1&feature=oembed" frameborder="0" allowfullscreen></iframe>) }

  #   it { expect(subject.oembed).to be_a(Hash) }
  #   it { expect(subject.oembed_html).to eql(expected_oembed_html) }
  #   describe "#metadata" do
  #     subject { instance.metadata }
  #     it { subject[:base_url].should eql("http://www.youtube.com/watch?v=g3DCEcSlfhw") }
  #     it { subject[:content_type].should eql("text/html") }
  #     it { subject[:title].should eql("'Virtuosos of Guitar 2008' festival, Moscow. Marcin Dylla") }
  #     it { subject[:html].should eql(expected_oembed_html) }
  #   end
  # end
end
