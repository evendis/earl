# frozen_string_literal: true

require 'spec_helper'

describe Earl do
  subject(:instance) { Earl[url] }

  vcr_base = 'feed'

  context 'when page has no feeds associated', vcr: { cassette_name: "#{vcr_base}/no_feed" } do
    let(:url) { 'https://www.google.com/' }
    it { expect(subject.feed?).to be false }
    it { expect(subject.rss_feed).to be_nil }
    it { expect(subject.feed).to be_nil }
  end

  context 'when page has rss feed associated', vcr: { cassette_name: "#{vcr_base}/with_rss_feed" } do
    let(:url) { 'https://rubyweekly.com/' }
    it { expect(subject.feed?).to be true }
    it { expect(subject.rss_feed).to eql('/rss/') }
    it { expect(subject.feed).to eql('/rss/') }
  end

  # # context "when page has atom feed associated" do
  # #   let(:url) { 'http:// still looking for a page that just has atom' }
  # #    { expect(subject.feed?).to be true }
  # #    { expect(subject.atom_feed).to eql('http://www.readwriteweb.com/atom.xml') }
  # #    { expect(subject.feed).to eql('http://www.readwriteweb.com/atom.xml') }
  # # end

  context 'when page has rss and atom feed associated', vcr: { cassette_name: "#{vcr_base}/with_atom_and_rss_feed" } do
    let(:url) { 'https://0xfe.blogspot.com/' }
    let(:expected_rss_feed) { 'https://0xfe.blogspot.com/feeds/posts/default?alt=rss' }
    let(:expected_atom_feed) { 'https://0xfe.blogspot.com/feeds/posts/default' }

    it { expect(subject.feed?).to be true }
    it { expect(subject.rss_feed).to eql(expected_rss_feed) }
    it { expect(subject.atom_feed).to eql(expected_atom_feed) }
    describe '#feed' do
      context 'default (rss)' do
        subject { instance.feed }
        it { expect(subject).to eql(expected_rss_feed) }
      end
      context 'rss prefered' do
        subject { instance.feed(:rss) }
        it { expect(subject).to eql(expected_rss_feed) }
      end
      context 'atom prefered' do
        subject { instance.feed(:atom) }
        it { expect(subject).to eql(expected_atom_feed) }
      end
    end
  end

  context 'when page IS an rss feed', vcr: { cassette_name: "#{vcr_base}/is_rss_feed" } do
    let(:url) { 'https://cprss.s3.amazonaws.com/rubyweekly.com.xml' }
    it { expect(subject.url).to eql(url) }
    it { expect(subject.base_url).to eql(url) }
    it { expect(subject.content_type).to eql('application/xml') }
    # TODO: fix rss feed detection
    # it { expect(subject.feed?).to be true }
    # it { expect(subject.rss_feed).to eql(url) }
    # it { expect(subject.feed).to eql(url) }
    it { expect(subject.feed?).to be false }
    it { expect(subject.rss_feed).to be_nil }
    it { expect(subject.feed).to be_nil }
  end

  context 'when page IS an atom feed', vcr: { cassette_name: "#{vcr_base}/is_atom_feed" } do
    let(:url) { 'https://0xfe.blogspot.com/feeds/posts/default' }
    it { expect(subject.url).to eql(url) }
    it { expect(subject.base_url).to eql(url) }
    it { expect(subject.content_type).to eql('application/atom+xml') }
    it { expect(subject.feed?).to be true }
    it { expect(subject.atom_feed).to eql(url) }
    it { expect(subject.feed).to eql(url) }
  end
end
