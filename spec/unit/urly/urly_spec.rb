require 'spec_helper'

describe Urly do


  describe '##new' do
    subject { Urly.new('http://test.host/') }
    its(:to_s) { should eql('http://test.host/') }
  end

  describe '[]=' do
    subject { Urly['http://test.host/'] }
    its(:to_s) { should eql('http://test.host/') }
  end

end
