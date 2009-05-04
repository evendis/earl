require File.dirname(__FILE__) + '/../spec_helper'

describe Earl::Url do

  before :each do
    Kernel.stub!(:open).and_return('document')
  end

  describe '[]' do
    it 'should assign the argument as its URL' do
      Earl::Url['http://test.host/'].to_s.should == 'http://test.host/'
    end
  end

  describe 'Discovering scrapers' do
    it 'should delegate to the scraper with the correct URL regexp if it is present'
    it 'should use the default scraper if none is present for the URL'
  end

end
