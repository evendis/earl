class Earl
  class TitleScraper < Earl::Scraper
    def scrape(response)
      response.css('title').each {|t| return t.content}
    end
  end
end
