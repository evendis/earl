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
        p @@registry
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

    def title(response)
    end

    def image(response)
    end
    
    def video(response)
    end

    def description(response)
    end

  end

end
