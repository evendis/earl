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

    def title
      scraper.title(response)
    end

    def image
      scraper.image(response)
    end
    
    def video
      scraper.image(response)
    end

    def description
      scraper.description(response)
    end

    class << self

      def [](url)
        new(url)
      end

      def self.register_scraper(scraper)
        @scrapers 
      end

    end

  end

end
