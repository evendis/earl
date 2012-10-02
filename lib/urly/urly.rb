require 'open-uri'
require 'oembedr'

class Urly

  attr_accessor :url, :options, :oembed

  def initialize(url, options={})
    @url = url
    @options = options
  end

  def to_s
    url
  end

  def uri
    @uri ||= URI.parse(url)
  end

  def uri_response
    @uri_response ||= open(uri)
  end

  # Returns
  # :base_url - the actual url (resolved after possible redirect) as a String
  # :content_type - mime type
  # :charset - returns a charset parameter in Content-Type field. It is downcased for canonicalization.
  # :content_encoding - returns a list of encodings in Content-Encoding field as an Array of String. The encodings are downcased for canonicalization.
  # :last_modified - returns a Time which represents Last-Modified field.
  def uri_response_attribute(name)
    if name == :base_url
      (uri_response_attribute(:base_uri) || url).to_s
    else
      uri_response && uri_response.respond_to?(name) && uri_response.send(name)
    end
  end
  protected :uri_response_attribute

  def uri_response_attributes
    [:content_type,:base_url,:charset,:content_encoding,:last_modified]
  end
  protected :uri_response_attributes


  def scraper
    Scraper.for(url)
  end

  def response
    @response ||= Nokogiri::HTML(uri_response)
  end

  # Returns a hash of link meta data, including:
  # :title, :description, :image (all attributes)
  # :base_url
  def metadata
    data = oembed || {}
    attributes.each do |attribute|
      if attribute_value = self.send(attribute)
        data[attribute] ||= attribute_value
      end
    end
    data
  end

  # Dispatch missing methods if a match for:
  # - uri_response_attributes
  # - scraper attributes
  def method_missing(method, *args)
    if uri_response_attributes.include?(method)
      return uri_response_attribute(method)
    elsif scraper.has_attribute?(method)
      return scraper.attribute(method, response)
    end
    super
  end

  # Returns a full array of attributes available for the link
  def attributes
    scraper.attributes.keys + uri_response_attributes + [:feed]
  end

  # Returns the options to be used for oembed
  def oembed_options
    { :maxwidth => "560", :maxheight => "315" }.merge(options[:oembed]||{})
  end

  # Returns the oembed meta data hash for the URL (or nil if not defined/available) e.g.
  # For http://www.youtube.com/watch?v=g3DCEcSlfhw:
  #   {
  #     "provider_url"=>"http://www.youtube.com/",
  #     "thumbnail_url"=>"http://i4.ytimg.com/vi/g3DCEcSlfhw/hqdefault.jpg",
  #     "title"=>"'Virtuosos of Guitar 2008' festival, Moscow. Marcin Dylla",
  #     "html"=>"<iframe width=\"459\" height=\"344\" src=\"http://www.youtube.com/embed/g3DCEcSlfhw?fs=1&feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>",
  #     "author_name"=>"guitarmagnet",
  #     "height"=>344,
  #     "thumbnail_width"=>480,
  #     "width"=>459,
  #     "version"=>"1.0",
  #     "author_url"=>"http://www.youtube.com/user/guitarmagnet",
  #     "provider_name"=>"YouTube",
  #     "type"=>"video",
  #     "thumbnail_height"=>360
  #   }
  #
  # +options+ defines a custom oembed options hash and will cause a re-fetch of the oembed metadata
  def oembed(options=nil)
    if options # use custom options, refetch oembed metadata
      @options[:oembed] = options
      @oembed = nil
    end
    begin
      @oembed ||= if h = Oembedr.fetch(base_url, :params => oembed_options).body
        h.keys.each do |key| # symbolize_keys!
          h[(key.to_sym rescue key) || key] = h.delete(key)
        end
        h
      end
    rescue
    end
    @oembed
  end

  # Returns the oembed code for the url (or nil if not defined/available)
  def oembed_html
    oembed && oembed[:html]
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
