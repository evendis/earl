require File.dirname(__FILE__) + '/../spec_helper'

describe Earl::Url do


  describe '[]' do
    before { Kernel.stub!(:open).and_return('document') }
    it 'should assign the argument as its URL' do
      Earl::Url['http://test.host/'].to_s.should == 'http://test.host/'
    end
  end


end
