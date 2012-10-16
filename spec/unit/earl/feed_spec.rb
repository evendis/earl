require 'spec_helper'

describe Earl do
  let(:instance) { Earl[url] }
  let(:url) { 'http:://example.com' }

  before { Earl.any_instance.stub(:uri).and_return(source) }
  subject { instance }

  context "when page has no feeds associated" do
    let(:source) { fixture(:page_without_feeds) }
    its(:has_feed?) { should be_false }
    its(:rss_feed) { should be_nil }
    its(:feed) { should be_nil }
  end

  context "when page has rss feed associated" do
    let(:source) { fixture(:page_with_rss_feed) }
    its(:has_feed?) { should be_true }
    its(:rss_feed) { should eql('http://www.readwriteweb.com/rss.xml') }
    its(:feed) { should eql('http://www.readwriteweb.com/rss.xml') }
  end

  context "when page has atom feed associated" do
    let(:source) { fixture(:page_with_atom_feed) }
    its(:has_feed?) { should be_true }
    its(:atom_feed) { should eql('http://www.readwriteweb.com/atom.xml') }
    its(:feed) { should eql('http://www.readwriteweb.com/atom.xml') }
  end

  context "when page has rss and atom feed associated" do
    let(:source) { fixture(:page_with_rss_and_atom_feeds) }
    its(:has_feed?) { should be_true }
    its(:rss_feed) { should eql('http://www.readwriteweb.com/rss.xml') }
    its(:atom_feed) { should eql('http://www.readwriteweb.com/atom.xml') }
    describe "#feed" do
      context "default (rss)" do
        subject { instance.feed }
        it { should eql('http://www.readwriteweb.com/rss.xml') }
      end
      context "rss prefered" do
        subject { instance.feed(:rss) }
        it { should eql('http://www.readwriteweb.com/rss.xml') }
      end
      context "atom prefered" do
        subject { instance.feed(:atom) }
        it { should eql('http://www.readwriteweb.com/atom.xml') }
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
