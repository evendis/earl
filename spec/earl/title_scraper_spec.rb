require File.dirname(__FILE__) + '/../spec_helper'

describe Earl::TitleScraper do
  it 'should return the contents of the HTML <title> tag' do
    Earl[fixture(:bicycles)].title.should == 'bicycles (bicycles) on Twitter'
  end
end
