module Early

  class Scraper

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

      def for(url)
        @@registry.each do |klass|
          return klass.new(url) if klass.regexp.match(url)
        end
        return Scraper.new(url)
      end

      private

        def register(scraper_klass)
          @@registry << scraper_klass
        end

    end

    def initialize(url)
      @url = url
    end

    def attribute(name, doc)
      return unless has_attribute?(name)
      self.attributes[name].call(doc)
    end

    def attributes
      if self.class.superclass == Early::Scraper
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
      doc.at('title').content
    end

    define_attribute :image do |doc|
      if doc.at('img')
        doc.at('img')['src']
      end
    end

    define_attribute :description do |doc|
      element = doc.at("meta[name='description']")
      if element
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

end
