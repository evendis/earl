module Earl

  class Scraper

    class << self
      @@registry = []
      attr_reader :regexp

      def match(regexp)
        @regexp = regexp
        register self
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

    def title(doc)
      doc.at('title').content
    end

    def image(doc)
      return nil unless doc.at('img')
      doc.at('img')['src']
    end
    
    def video(doc)
      nil
    end

    def description(doc)
      element = doc.at("meta[name='description']")
      return nil unless element
      element['content']
    end

  end

end
