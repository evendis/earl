require File.dirname(__FILE__) + '/../spec_helper'

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
        match /^http\:\/\/www\.test\.com\/$/
        define_attribute(:title) {|response| :test_title }
      end
    end

    it 'should return the result if the URL matches the scraper regexp' do
      Earl::Url['http://www.test.com/'].title.should == :test_title
    end
  end

  describe 'When retrieving the response' do
    it 'should return a Nokogiri document' do
      Earl::Url['test'].response.css('html').size.should == 1
    end
  end

  describe 'Scraper inheritance' do
    class SubScraper < Earl::Scraper
      define_attribute :some_attribute do |doc|
        doc
      end
    end

    it 'inherits all attributes from its superclass' do
      scraper = SubScraper.new('foo.bar')
      scraper.attributes.should include(:title)
      scraper.attributes.should include(:description)
      scraper.attributes.should include(:image)
      scraper.attributes.should include(:some_attribute)
    end
  end

end
