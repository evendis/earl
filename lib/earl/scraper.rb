# frozen_string_literal: true

# Base class for nokogiri page scraping
class Earl::Scraper
  class << self
    @@registry = []
    attr_reader :regexp, :attributes

    def match(regexp)
      @regexp = regexp
      register self
    end

    def define_attribute(name, &block)
      @attributes ||= {}
      @attributes[name] = block
    end

    def for(url, earl_source)
      @@registry.each do |klass|
        return klass.new(url, earl_source) if klass.regexp.match(url)
      end
      Earl::Scraper.new(url, earl_source)
    end

    def register(scraper_klass)
      @@registry << scraper_klass
    end
    private :register
  end

  attr_reader :earl_source

  def initialize(url, earl_source = nil)
    @url = url
    @earl_source = earl_source
  end

  def response
    @response ||= earl_source && Nokogiri::HTML(earl_source.uri_response)
  end

  def attribute(name)
    return unless attribute?(name)

    attributes[name].call(response)
  end

  def attributes
    if self.class.superclass == Earl::Scraper
      self.class.superclass.attributes.merge(self.class.attributes)
    else
      self.class.attributes
    end
  end

  def attribute?(name)
    return false unless self.class.attributes

    attributes.key?(name)
  end

  define_attribute :title do |doc|
    if title = doc.at('title')
      title.content
    end
  end

  define_attribute :image do |doc|
    if first_image = doc.at('img')
      first_image['src']
    end
  end

  define_attribute :description do |doc|
    if element = doc.at("meta[name='description']")
      element['content']
    end
  end

  define_attribute :rss_feed do |doc|
    if element = doc.at("link[type='application/rss+xml']")
      element['href']
    end
  end

  define_attribute :atom_feed do |doc|
    if element = doc.at("link[type='application/atom+xml']")
      element['href']
    end
  end
end
