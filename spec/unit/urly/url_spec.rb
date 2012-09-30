require 'spec_helper'

describe Urly do


  describe '##new' do
    before { Urly.any_instance.stub(:uri).and_return('document') }
    subject { Urly.new('http://test.host/') }
    its(:to_s) { should eql('http://test.host/') }
  end

  describe '[]=' do
    before { Urly.any_instance.stub(:uri).and_return('document') }
    subject { Urly['http://test.host/'] }
    its(:to_s) { should eql('http://test.host/') }
  end

end
