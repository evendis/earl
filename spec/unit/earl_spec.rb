# frozen_string_literal: true

require 'spec_helper'

describe Earl do
  before do
    allow_any_instance_of(Earl).to receive(:uri_response).and_return(source)
  end
  let(:url) { 'http://mock.net' }
  subject(:instance) { Earl[url] }

  describe '#title' do
    subject { instance.title }
    context 'example with title tag' do
      let(:source) { fixture(:bicycles) }
      it { expect(subject).to eql('bicycles (bicycles) on Twitter') }
    end
    context 'youtube example with title tag' do
      let(:source) { fixture(:youtube) }
      it { expect(subject).to eql('YouTube - Symptoms of Swine Flu') }
    end
  end

  describe '#description' do
    subject { instance.description }
    context 'example with description tag' do
      let(:source) { fixture(:bicycles) }
      it { expect(subject).to eql('I write business plans for a living and fiction to stay sane.  I also try my hand at all sorts of creative side projects: painting, game dev, whiskey drinking..') }
    end
    context 'example without description tag' do
      let(:source) { fixture(:bicycles_without_description) }
      it { expect(subject).to be_nil }
    end
  end

  describe '#image' do
    subject { instance.image }
    context 'example with image tag' do
      let(:source) { fixture(:bicycles) }
      it { expect(subject).to eql('http://assets0.twitter.com/images/loader.gif') }
    end
    context 'example without image tag' do
      let(:source) { fixture(:bicycles_without_images) }
      it { expect(subject).to be_nil }
    end
  end

  describe '#attributes' do
    subject { instance.attributes }
    let(:source) { fixture(:bicycles) }
    it 'is an array of expected elements' do
      expect(subject).to be_an(Array)
      %i[description title image].each do |attribute|
        expect(subject).to include(attribute)
      end
    end
  end

  describe '#metadata' do
    subject { instance.metadata }
    let(:source) { fixture(:bicycles) }
    it { expect(subject).to be_a(Hash) }
    it 'has the expected elements' do
      expect(subject).to eql({
        title: 'bicycles (bicycles) on Twitter',
        description: 'I write business plans for a living and fiction to stay sane.  I also try my hand at all sorts of creative side projects: painting, game dev, whiskey drinking..',
        image: 'http://assets0.twitter.com/images/loader.gif',
        rss_feed: '/statuses/user_timeline/user_id.rss',
        base_url: 'http://mock.net',
        feed: '/statuses/user_timeline/user_id.rss'
      })
    end
  end
end
