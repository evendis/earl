require 'spec_helper'

describe Urly::Url do


  describe '[]' do
    before { Urly::Url.any_instance.stub(:uri).and_return('document') }
    it 'should assign the argument as its URL' do
      Urly::Url['http://test.host/'].to_s.should == 'http://test.host/'
    end
  end


end
