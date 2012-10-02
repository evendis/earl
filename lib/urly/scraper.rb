class Urly::Scraper

  class << self
    @@registry = []
    attr_reader :regexp
    attr_reader :attributes

    def match(regexp)
      @regexp = regexp
      register self
    end

    def define_attribute(name, &block)
      @attributes ||= {}
      @attributes[name] = block
    end

    def for(url, urly_source)
      @@registry.each do |klass|
        return klass.new(url,urly_source) if klass.regexp.match(url)
      end
      return Urly::Scraper.new(url,urly_source)
    end

    private

      def register(scraper_klass)
        @@registry << scraper_klass
      end

  end

  attr_reader :urly_source

  def initialize(url, urly_source = nil)
    @url = url
    @urly_source = urly_source
  end

  def response
    @response ||= urly_source && Nokogiri::HTML(urly_source.uri_response)
  end

  def attribute(name)
    return unless has_attribute?(name)
    self.attributes[name].call(response)
  end

  def attributes
    if self.class.superclass == Urly::Scraper
      self.class.superclass.attributes.merge(self.class.attributes)
    else
      self.class.attributes
    end
  end

  def has_attribute?(name)
    return false unless self.class.attributes
    self.attributes.has_key?(name)
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

