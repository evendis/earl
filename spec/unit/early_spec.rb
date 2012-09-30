require 'spec_helper'

describe Early do

  before { Early::Url.any_instance.stub(:uri).and_return(source) }
  let(:url) { 'http://mock.net' }
  let(:early) { Early::Url[url] }
  subject { early }

  describe '#title' do
    context "example with title tag" do
      let(:source) { fixture(:bicycles) }
      its(:title) { should eql('bicycles (bicycles) on Twitter') }
    end
    context "youtube example with title tag" do
      let(:source) { fixture(:youtube) }
      its(:title) { should eql('YouTube - Symptoms of Swine Flu') }
    end
  end

  describe '#description' do
    context "example with description tag" do
      let(:source) { fixture(:bicycles) }
      its(:description) { should eql('I write business plans for a living and fiction to stay sane.  I also try my hand at all sorts of creative side projects: painting, game dev, whiskey drinking..') }
    end
    context "example without description tag" do
      let(:source) { fixture(:bicycles_without_description) }
      its(:description) { should be_nil }
    end
  end

  describe '#image' do
    context "example with image tag" do
      let(:source) { fixture(:bicycles) }
      its(:image) { should eql('http://assets0.twitter.com/images/loader.gif') }
    end
    context "example without image tag" do
      let(:source) { fixture(:bicycles_without_images) }
      its(:image) { should be_nil }
    end
  end

  describe '#attributes' do
    let(:source) { fixture(:bicycles) }
    its(:attributes) { should be_an(Array) }
    [ :description, :title, :image ].each do |attribute|
      its(:attributes) { should include(attribute) }
    end
  end

end

