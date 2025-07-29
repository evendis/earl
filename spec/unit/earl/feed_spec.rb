require 'spec_helper'

describe Earl do
  let(:instance) { Earl[url] }
  let(:url) { 'http:://example.com' }

  before do
    allow_any_instance_of(Earl).to receive(:uri).and_return(source)
  end
  subject { instance }

  context "when page has no feeds associated" do
    let(:source) { fixture(:page_without_feeds) }
    it { expect(subject.has_feed?).to be false }
    it { expect(subject.rss_feed).to be_nil }
    it { expect(subject.feed).to be_nil }
  end

  context "when page has rss feed associated" do
    let(:source) { fixture(:page_with_rss_feed) }
    it { expect(subject.has_feed?).to be true }
    it { expect(subject.rss_feed).to eql('http://www.readwriteweb.com/rss.xml') }
    it { expect(subject.feed).to eql('http://www.readwriteweb.com/rss.xml') }
  end

  context "when page has atom feed associated" do
    let(:source) { fixture(:page_with_atom_feed) }
    it { expect(subject.has_feed?).to be true }
    it { expect(subject.atom_feed).to eql('http://www.readwriteweb.com/atom.xml') }
    it { expect(subject.feed).to eql('http://www.readwriteweb.com/atom.xml') }
  end

  context "when page has rss and atom feed associated" do
    let(:source) { fixture(:page_with_rss_and_atom_feeds) }
    it { expect(subject.has_feed?).to be true }
    it { expect(subject.rss_feed).to eql('http://www.readwriteweb.com/rss.xml') }
    it { expect(subject.atom_feed).to eql('http://www.readwriteweb.com/atom.xml') }
    describe "#feed" do
      context "default (rss)" do
        subject { instance.feed }
        it { expect(subject).to eql('http://www.readwriteweb.com/rss.xml') }
      end
      context "rss prefered" do
        subject { instance.feed(:rss) }
        it { expect(subject).to eql('http://www.readwriteweb.com/rss.xml') }
      end
      context "atom prefered" do
        subject { instance.feed(:atom) }
        it { expect(subject).to eql('http://www.readwriteweb.com/atom.xml') }
      end
    end
  end

  # context "when page IS an rss feed" do
  #   let(:source) { fixture(:page_as_rss) }
  #   its(:has_feed?) { should be_true }
  #   its(:rss_feed) { should eql(url) }
  #   its(:feed) { should eql(url) }
  # end
end
