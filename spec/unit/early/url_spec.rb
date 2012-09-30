require 'spec_helper'

describe Early::Url do


  describe '[]' do
    before { Early::Url.any_instance.stub(:uri).and_return('document') }
    it 'should assign the argument as its URL' do
      Early::Url['http://test.host/'].to_s.should == 'http://test.host/'
    end
  end


end
