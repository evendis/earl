require 'spec_helper'

class MockOembedResponse
  def body
    { 'html' => '<iframe/>' }
  end
end

describe Earl do
  let(:instance) { Earl.new(url,options) }
  let(:url) { 'http:://example.com' }
  let(:options) { {} }

  describe "#oembed_options" do
    subject { instance.oembed_options }
    context "with default options" do
      let(:expected) { { :maxwidth => "560", :maxheight => "315" } }
      it { expect(subject).to eql(expected) }
    end
    context "with custom options" do
      let(:options) { { :oembed => { :maxwidth => "260" } } }
      let(:expected) { { :maxwidth => "260", :maxheight => "315" } }
      it { expect(subject).to eql(expected) }
    end
    context "with custom options passed to oembed" do
      let(:expected) { { :maxwidth => "360", :maxheight => "315" } }
      before do
        allow(Oembedr).to receive(:fetch).and_return(nil)
        instance.oembed({ :maxwidth => "360" })
      end
      it { expect(subject).to eql(expected) }
    end
  end

  describe "#oembed" do
    let(:dummy_response) { MockOembedResponse.new }
    before do
      expect(instance).to receive(:base_url).and_return('')
      expect(Oembedr).to receive(:fetch).and_return(dummy_response)
    end
    subject { instance.oembed }
    it { expect(subject).to eql({ :html => '<iframe/>' }) }
    describe "#oembed_html" do
      subject { instance.oembed_html }
      it { expect(subject).to eql('<iframe/>') }
    end
  end
end
