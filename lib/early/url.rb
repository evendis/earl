require 'open-uri'

module Early

  class Url

    attr_accessor :url

    def initialize(url)
      @url = url
    end

    def uri
      @uri ||= URI.parse(url)
    end

    def uri_response
      @uri_response ||= open(uri)
    end

    def content_type
      @content_type ||= uri_response && uri_response.content_type
    end

    def base_uri
      @base_uri ||= uri_response && uri_response.base_uri
    end

    def base_url
      base_uri && base_uri.to_s || url
    end

    def scraper
      Scraper.for(url)
    end

    def response
      @response ||= Nokogiri::HTML(uri_response)
    end

    def to_s
      url
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
