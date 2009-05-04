require 'spec_helper'

describe Earl do

  describe 'When retrieving the page title' do
    it 'should return the contents of the title tag' do
      Earl::Url[fixture(:bicycles)].title.should == 'bicycles (bicycles) on Twitter'
      Earl::Url[fixture(:youtube)].title.should == 'YouTube - Symptoms of Swine Flu'
    end
  end

  describe 'When retrieving the page description' do
    it 'should return the contents of the meta description tag if one is present' do
      Earl::Url[fixture(:bicycles)].description.should == 'I write business plans for a living and fiction to stay sane.  I also try my hand at all sorts of creative side projects: painting, game dev, whiskey drinking..'
    end

    it 'should return nil if there is no meta description tag' do
      Earl::Url[fixture(:bicycles_without_description)].description.should be_nil
    end
  end

  describe 'When retrieving the page image' do
    it 'should return the URL of the first image on the page' do
      Earl::Url[fixture(:bicycles)].image.should ==  'http://assets0.twitter.com/images/loader.gif'
    end

    it 'should return nil if there are no images on the page' do
      Earl::Url[fixture(:bicycles_without_images)].image.should be_nil
    end
  end

  describe 'when retrieving the page video' do
    it 'should return nil by default' do
      Earl::Url[fixture(:bicycles)].video.should be_nil
    end
  end

end

