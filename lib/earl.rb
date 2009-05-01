require 'rubygems'
gem     'activesupport'
require 'activesupport'
gem     'tenderlove-nokogiri'
require 'nokogiri'

class Earl

  class Scraper

    class << self

      def validates_url(regexp)
        @url_regexp = regexp
      end

      attr_reader :url_regexp

    end

    def initialize(url)
      @url = url
    end

    def url_valid?
      return true unless self.class.url_regexp
      !! self.class.url_regexp.match(@url)
    end

    def response
      @response ||= Nokogiri::HTML(Kernel.open(@url))
    end

    def execute
      return nil unless url_valid?
      scrape(response)
    end
  end
  
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def self.[](url)
    new(url)
  end

  def method_missing(method, *args)
    klass = "#{method.to_s.classify}Scraper".constantize
    super unless klass
    klass.new(@url).execute
  end

end
