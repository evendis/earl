require 'spec_helper'

describe Earl do
  describe '.new' do
    subject { Earl.new('http://test.host/') }
    it { expect(subject.to_s).to eql('http://test.host/') }
  end

  describe '[]=' do
    subject { Earl['http://test.host/'] }
    it { expect(subject.to_s).to eql('http://test.host/') }
  end
end
