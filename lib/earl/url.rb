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

    # Returns true if there is an ATOM or RSS feed associated with this URL.
    def has_feed?
      !feed.nil?
    end

    # Returns the feed URL associated with this URL.
    # Returns RSS by default, or ATOM if +prefer+ is not :rss.
    def feed(prefer = :rss)
      rss = rss_feed
      atom = atom_feed
      if rss && atom
        prefer == :rss ? rss : atom
      else
        rss || atom
      end
    end

    class << self

      def [](url)
        new(url)
      end

    end

  end

end
