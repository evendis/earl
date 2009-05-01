require 'spec_helper'

describe Earl do

  before :each do
    Kernel.stub!(:open).and_return('document')
  end

  describe '[]' do
    it 'should assign the argument as its URL' do
      Earl['http://test.host/'].url.should == 'http://test.host/'
    end
  end

  describe 'Discovering scrapers' do
    it 'should make the Earl instance respond to each by name' do
      class Earl::TitleScraper < Earl::Scraper
        def scrape(response); :title_result; end
      end
      class Earl::YouTubeEmbedHtmlScraper < Earl::Scraper
        def scrape(response); :you_tube_embed_html_result; end
      end
      Earl['http://foo.bar'].title.should == :title_result
      Earl['http://foo.bar'].you_tube_embed_html.should == :you_tube_embed_html_result
    end
  end

end

describe Earl::Scraper do

  before :each do
    Kernel.stub!(:open).and_return(<<-DOC
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
    <html></html>
                                   DOC
                                   )
  end

  describe 'When validating URLs' do
    before :each do
      class Earl::TestScraper < Earl::Scraper
        validates_url /^http\:\/\/www\.test\.com\/$/
        def scrape(response); :test_result; end
      end
    end

    it 'should return nil upon access if the URL does not match' do
      Earl['foobar'].test.should be_nil
    end

    it 'should return the result if the URL does match' do
      Earl['http://www.test.com/'].test.should == :test_result
    end
  end

  describe 'When retrieving the response' do
    before :each do
      class Earl::PassthroughScraper < Earl::Scraper
        def scrape(response); response; end
      end
    end

    it 'should return a Nokogiri document' do
      Earl['test'].passthrough.css('html').size.should == 1
    end
  end

end
