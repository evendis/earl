require File.dirname(__FILE__) + '/../spec_helper'

describe Earl::YoutubeEmbedCodeScraper do
  it 'should return the contents of the embed code box' do
    Earl[fixture(:youtube)].youtube_embed_code.should == '<object width="425" height="344"><param name="movie" value="http://www.youtube.com/v/0wK1127fHQ4&hl=en&fs=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/0wK1127fHQ4&hl=en&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>'
  end
end
