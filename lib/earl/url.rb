module Earl

  class Url
    
    def scraper
      Scraper.for(@url)
    end
    
    def response
      @response ||= Nokogiri::HTML(Kernel.open(@url))
    end

    def initialize(url)
      @url = url
    end

    def to_s
      @url
    end

    def method_missing(method, *args)
      if scraper.has_attribute?(method)
        return scraper.attribute(method, response)
      end

      super
    end

    def attributes
      scraper.attributes.keys
    end

    class << self

      def [](url)
        new(url)
      end

    end

  end

end
