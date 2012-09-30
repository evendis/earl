require File.dirname(__FILE__) + '/../spec_helper'

describe Early::Url do


  describe '[]' do
    before { Kernel.stub!(:open).and_return('document') }
    it 'should assign the argument as its URL' do
      Early::Url['http://test.host/'].to_s.should == 'http://test.host/'
    end
  end


end
