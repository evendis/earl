require File.dirname(__FILE__) + '/../spec_helper'

describe Earl::YoutubeScraper do
  
  it 'should return the embed tag for a Youtube video' do
    Earl::Url['http://www.youtube.com/watch?v=0wK1127fHQ4'].video.should == '<object width="425" height="344"><param name="movie" value="http://www.youtube.com/v/0wK1127fHQ4&hl=en&fs=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/0wK1127fHQ4&hl=en&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>'
    Earl::Url['http://www.youtube.com/watch?v=4xfiPRxcXp4&feature=channel'].video.should == '<object width="425" height="344"><param name="movie" value="http://www.youtube.com/v/4xfiPRxcXp4&hl=en&fs=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/4xfiPRxcXp4&hl=en&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>'
  end

  it 'should have the description from the gutter' do
    Earl::Url['http://www.youtube.com/watch?v=4xfiPRxcXp4&feature=channel'].
      description.should == 'This podcast discusses the actions and goals of the Centers for Disease Control and Prevention, related to the current outbreak of H1N1 flu (swine flu).'
  end

end
