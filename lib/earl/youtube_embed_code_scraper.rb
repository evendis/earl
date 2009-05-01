class Earl
  class YoutubeEmbedCodeScraper < Earl::Scraper
    def scrape(response)
      response.css('#embed_code').each {|t| return t['value']}
    end
  end
end
