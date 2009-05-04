module Earl
  class YoutubeScraper < Earl::Scraper
    match /^http\:\/\/www\.youtube\.com\/watch\?v\=.*$/

    def video(doc)
      doc.at('#embed_code')['value']
    end
  end
end
