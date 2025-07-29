# frozen_string_literal: true

require 'spec_helper'

describe Earl do
  subject(:instance) { Earl[url] }

  vcr_base = 'oembed'

  context 'when page does not support oembed', vcr: { cassette_name: "#{vcr_base}/no_oembed" } do
    let(:url) { 'https://github.com/evendis/earl' }
    it { expect(subject.oembed).to be_nil }
    it { expect(subject.oembed_html).to be_nil }
    describe '#metadata' do
      subject { instance.metadata }
      it { expect(subject[:base_url]).to match(%r{github\.com/evendis/earl}) }
      it { expect(subject[:content_type]).to eql('text/html') }
      it { expect(subject[:html]).to be_nil }
    end
  end

  context 'when youtube oembed', vcr: { cassette_name: "#{vcr_base}/youtube_oembed" } do
    let(:url) { 'https://www.youtube.com/watch?v=hNSkCqMUMQA' }
    let(:expected_oembed_html) { 'https://www.youtube.com/embed/hNSkCqMUMQA?feature=oembed' }

    it { expect(subject.oembed).to be_a(Hash) }
    it { expect(subject.oembed_html).to include(expected_oembed_html) }
    describe '#metadata' do
      subject { instance.metadata }
      it { expect(subject[:base_url]).to eql(url) }
      it { expect(subject[:content_type]).to eql('text/html') }
      it { expect(subject[:title]).to eql('[JA][Keynote] Ruby Taught Me About Encoding Under the Hood / Mari Imaizumi @ima1zumi') }
      it { expect(subject[:html]).to include(expected_oembed_html) }
    end
  end
end
