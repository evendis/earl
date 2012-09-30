require 'spec_helper'

# These tests hit real network endpoints - not included in the default test runs. Run with:
#  rake spec:integration
# or
#  rake spec:all
#
describe Early do
  let(:early) { Early::Url[url] }

  subject { early }

  context "when page has no feeds associated" do
    let(:url) { 'http://google.com/' }
    its(:has_feed?) { should be_false }
    its(:rss_feed) { should be_nil }
    its(:feed) { should be_nil }
  end

  context "when page has rss feed associated" do
    let(:url) { 'http://www.readwriteweb.com/' }
    its(:has_feed?) { should be_true }
    its(:rss_feed) { should eql('http://www.readwriteweb.com/rss.xml') }
    its(:feed) { should eql('http://www.readwriteweb.com/rss.xml') }
  end

  # context "when page has atom feed associated" do
  #   let(:url) { 'http:// still looking for a page that just has atom' }
  #   its(:has_feed?) { should be_true }
  #   its(:atom_feed) { should eql('http://www.readwriteweb.com/atom.xml') }
  #   its(:feed) { should eql('http://www.readwriteweb.com/atom.xml') }
  # end

  context "when page has rss and atom feed associated" do
    let(:url) { 'http://tardate.blogspot.com' }
    let(:expected_rss_feed) { 'http://tardate.blogspot.com/feeds/posts/default?alt=rss' }
    let(:expected_atom_feed) { 'http://tardate.blogspot.com/feeds/posts/default' }

    its(:has_feed?) { should be_true }
    its(:rss_feed) { should eql(expected_rss_feed) }
    its(:atom_feed) { should eql(expected_atom_feed) }
    describe "#feed" do
      context "default (rss)" do
        subject { early.feed }
        it { should eql(expected_rss_feed) }
      end
      context "rss prefered" do
        subject { early.feed(:rss) }
        it { should eql(expected_rss_feed) }
      end
      context "atom prefered" do
        subject { early.feed(:atom) }
        it { should eql(expected_atom_feed) }
      end
    end
  end

  context "when page IS an rss feed" do
    let(:url) { 'http://www.readwriteweb.com/rss.xml' }
    its(:url) { should eql(url) }
    its(:base_url) { should eql('http://feeds.feedburner.com/readwriteweb') }
    its(:content_type) { should eql('text/xml') }
    its(:has_feed?) { should be_true }
    its(:rss_feed) { should eql(url) }
    its(:feed) { should eql(url) }
  end

  context "when page IS an atom feed" do
    let(:url) { 'http://tardate.blogspot.com/feeds/posts/default' }
    its(:url) { should eql(url) }
    its(:base_url) { should eql('http://feeds.feedburner.com/tardate') }
    its(:content_type) { should eql('text/xml') }
    its(:has_feed?) { should be_true }
    its(:atom_feed) { should eql(url) }
    its(:feed) { should eql(url) }
  end

end
