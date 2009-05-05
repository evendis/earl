module Earl
  class YoutubeScraper < Earl::Scraper
    match /^http\:\/\/www\.youtube\.com\/watch\?v\=.*$/

    define_attribute :video do |doc|
      doc.at('#embed_code')['value']
    end
  end
end
