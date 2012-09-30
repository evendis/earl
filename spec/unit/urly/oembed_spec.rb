require 'spec_helper'

class MockOembedResponse
  def body
    { 'html' => '<iframe/>' }
  end
end

describe Urly do
  let(:instance) { Urly.new(url,options) }
  let(:url) { 'http:://example.com' }
  let(:options) { {} }

  describe "#oembed_options" do
    subject { instance.oembed_options }
    context "with default options" do
      let(:expected) { { :maxwidth => "560", :maxheight => "315" } }
      it { should eql(expected) }
    end
    context "with custom options" do
      let(:options) { { :oembed => { :maxwidth => "260" } } }
      let(:expected) { { :maxwidth => "260", :maxheight => "315" } }
      it { should eql(expected) }
    end
    context "with custom options passed to oembed" do
      let(:expected) { { :maxwidth => "360", :maxheight => "315" } }
      before do
        Oembedr.stub(:fetch).and_return(nil)
        instance.oembed({ :maxwidth => "360" })
      end
      it { should eql(expected) }
    end
  end

  describe "#oembed" do
    let(:dummy_response) { MockOembedResponse.new }
    before do
      instance.stub(:base_url).and_return('')
      Oembedr.stub(:fetch).and_return(dummy_response)
    end
    subject { instance.oembed }
    it { should eql({ 'html' => '<iframe/>' }) }
    describe "#oembed_html" do
      subject { instance.oembed_html }
      it { should eql('<iframe/>') }
    end
  end

end