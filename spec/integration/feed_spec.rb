require 'spec_helper'

# These tests hit real network endpoints - not included in the default test runs. Run with:
#  rake spec:integration
# or
#  rake spec:all
#
describe Earl do
  subject(:instance) { Earl[url] }

  context "when page has no feeds associated" do
    let(:url) { 'https://google.com/' }
    it { expect(subject.has_feed?).to be false }
    it { expect(subject.rss_feed).to be_nil }
    it { expect(subject.feed).to be_nil }
  end

  context "when page has rss feed associated" do
    let(:url) { 'https://rubyweekly.com/' }
    it { expect(subject.has_feed?).to be true }
    it { expect(subject.rss_feed).to eql('/rss/') }
    it { expect(subject.feed).to eql('/rss/') }
  end

  # context "when page has atom feed associated" do
  #   let(:url) { 'http:// still looking for a page that just has atom' }
  #   its(:has_feed?) { should be_true }
  #   its(:atom_feed) { should eql('http://www.readwriteweb.com/atom.xml') }
  #   its(:feed) { should eql('http://www.readwriteweb.com/atom.xml') }
  # end

  context "when page has rss and atom feed associated" do
    let(:url) { 'https://0xfe.blogspot.com/' }
    let(:expected_rss_feed) { 'https://0xfe.blogspot.com/feeds/posts/default?alt=rss' }
    let(:expected_atom_feed) { 'https://0xfe.blogspot.com/feeds/posts/default' }

    it { expect(subject.has_feed?).to be true }
    it { expect(subject.rss_feed).to eql(expected_rss_feed) }
    it { expect(subject.atom_feed).to eql(expected_atom_feed) }
    describe "#feed" do
      context "default (rss)" do
        subject { instance.feed }
        it { expect(subject).to eql(expected_rss_feed) }
      end
      context "rss prefered" do
        subject { instance.feed(:rss) }
        it { expect(subject).to eql(expected_rss_feed) }
      end
      context "atom prefered" do
        subject { instance.feed(:atom) }
        it { expect(subject).to eql(expected_atom_feed) }
      end
    end
  end

  # context "when page IS an rss feed" do
  #   let(:url) { 'https://cprss.s3.amazonaws.com/rubyweekly.com.xml' }
  #   it { expect(subject.url).to eql(url) }
  #   it { expect(subject.base_url).to eql(url) }
  #   it { expect(subject.content_type).to eql('application/xml') }
  #   it { expect(subject.has_feed?).to be true }
  #   it { expect(subject.rss_feed).to eql(url) }
  #   it { expect(subject.feed).to eql(url) }
  # end

  context "when page IS an atom feed" do
    let(:url) { 'https://0xfe.blogspot.com/feeds/posts/default' }
    it { expect(subject.url).to eql(url) }
    it { expect(subject.base_url).to eql(url) }
    it { expect(subject.content_type).to eql('application/atom+xml') }
    it { expect(subject.has_feed?).to be true }
    it { expect(subject.atom_feed).to eql(url) }
    it { expect(subject.feed).to eql(url) }
  end
end
