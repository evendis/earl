require 'spec_helper'

describe Earl::Scraper do
  before do
    allow_any_instance_of(Earl).to receive(:uri_response).and_return(<<-DOC
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
    <html></html>
    DOC
    )
  end

  describe 'When validating URLs' do
    before do
      class Earl::TestScraper < Earl::Scraper
        match /^http\:\/\/www\.test\.com\/$/
        define_attribute(:title) {|response| :test_title }
      end
    end

    it 'returns the result if the URL matches the scraper regexp' do
      expect(Earl['http://www.test.com/'].title).to eql :test_title
    end
  end

  describe 'When retrieving the response' do
    it 'returns a Nokogiri document' do
      expect(Earl['test'].response.css('html').size).to eql 1
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
      expect(scraper.attributes).to include(:title)
      expect(scraper.attributes).to include(:description)
      expect(scraper.attributes).to include(:image)
      expect(scraper.attributes).to include(:some_attribute)
    end
  end
end
