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

end
