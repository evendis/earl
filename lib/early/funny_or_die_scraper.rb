module Early
  class FunnyOrDieScraper < Early::Scraper
    match /^http\:\/\/www\.funnyordie\.com\/videos\/(.*)$/

    define_attribute :video do |doc|
      doc.at('input#embed')['value']
    end
  end
end
