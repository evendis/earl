require 'spec_helper'

describe Earl do


  describe '##new' do
    subject { Earl.new('http://test.host/') }
    its(:to_s) { should eql('http://test.host/') }
  end

  describe '[]=' do
    subject { Earl['http://test.host/'] }
    its(:to_s) { should eql('http://test.host/') }
  end

end
