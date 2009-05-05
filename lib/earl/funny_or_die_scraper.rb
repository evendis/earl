module Earl
  class FunnyOrDieScraper < Earl::Scraper
    match /^http\:\/\/www\.funnyordie\.com\/videos\/(.*)$/

    define_attribute :video do |doc|
      doc.at('input#embed')['value']
    end
  end
end
