# Earl

Earl wants to help you scrape all the relevant metadata for your favorite web pages so you can be as cool as
Facebook when displaying user-submitted link content. Earl returns details like titles, descriptions, content type,
associated feeds, and OEmbed definitions if available.

Earl is based on an original source project called _earl_ by [teejayvanslyke](https://github.com/teejayvanslyke/earl) (but never released as a gem).
The revamp was done by [Paul Gallagher](<https://github.com/tardate>), and master source is currently
available at <https://github.com/evendis/earl>.

The Earl gem is officially named _earl_. Big thanks go to [jeremyruppel](https://github.com/jeremyruppel) who
contributed the ownership of the _earl_ gem name. The original _earl_ gem had a somewhat similar purpose - it is now defunct, but still available up to version 0.3.0 via rubgems. Any _earl_ gem with version 1.0.0 or higher is the new gem release (and is in no way backwardly compatible with
earlier versions).

## The Earl Cookbook

### How do instantiate Earl?

Pass any url-like string to Earl:

    my_earl_instance = Earl.new('https://github.com/evendis/earl')
    #
    # or using the []= convenience method:
    my_earl_instance = Earl['https://github.com/evendis/earl']

### How do I inspect details of the page?

    earl = Earl['https://github.com/evendis/earl']
    earl.title
    =>  "evendis/earl · GitHub"
    earl.description
    => "earl - URL metadata API for scraping titles, descriptions, images, and videos from URL's."
    earl.image
    => "https://a248.e.akamai.net/assets.github.com/images/modules/header/logov7@4x.png?1340935010"

### How do I get oembed details for a link?

Earl will get oembed details for a link if they are available.

    earl = Earl['https://www.youtube.com/watch?v=hNSkCqMUMQA']
    earl.oembed
    => {:title=>"[JA][Keynote] Ruby Taught Me About Encoding Under the Hood / Mari Imaizumi @ima1zumi",
        :author_name=>"RubyKaigi",
        :author_url=>"https://www.youtube.com/@rubykaigi4884",
        :type=>"video",
        :height=>113,
        :width=>200,
        :version=>"1.0",
        :provider_name=>"YouTube",
        :provider_url=>"https://www.youtube.com/",
        :thumbnail_height=>360,
        :thumbnail_width=>480,
        :thumbnail_url=>"https://i.ytimg.com/vi/hNSkCqMUMQA/hqdefault.jpg",
        :html=>
        "<iframe width=\"200\" height=\"113\" src=\"https://www.youtube.com/embed/hNSkCqMUMQA?feature=oembed\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen title=\"[JA][Keynote] Ruby Taught Me About Encoding Under the Hood / Mari Imaizumi @ima1zumi\"></iframe>"}
    # to get the embed code:
    earl.oembed_html
    => "<iframe width=\"200\" height=\"113\" src=\"https://www.youtube.com/embed/hNSkCqMUMQA?feature=oembed\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen title=\"[JA][Keynote] Ruby Taught Me About Encoding Under the Hood / Mari Imaizumi @ima1zumi\"></iframe>"

### How do I customise the oembed link?

Supported oembed parameters may be provided with to `Earl.new` or to the `oembed` call:

    earl = Earl.new('https://www.youtube.com/watch?v=hNSkCqMUMQA', { oembed: { maxwidth: '200', maxheight: '320' }})
    earl.oembed_html
    => "<iframe width=\"200\" height=\"113\" src=\"https://www.youtube.com/embed/hNSkCqMUMQA?feature=oembed\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen title=\"[JA][Keynote] Ruby Taught Me About Encoding Under the Hood / Mari Imaizumi @ima1zumi\"></iframe>"

### How do I inspect what attributes are available for a page?

To see all of the attributes a URL provides, simply ask:

    earl = Earl['https://github.com/evendis/earl']
    earl.attributes
    => [:title, :image, :description, :rss_feed, :atom_feed, :content_type, :base_url, :charset, :content_encoding, :headers, :feed]

### How can I extend Earl to scrape additional page details?

Need to scrape additional page details currently supported by Earl?  Implement your own scraper:

    class QotdScraper < Earl::Scraper
      match /^http\:\/\/www\.quotationspage\.com\/qotd\.html$/

      define_attribute :qotd do |doc|
        doc.at('dt.quote a').text
      end
    end

The define_attribute method will supply you with a Nokogiri document which you can traverse to your heart's content.
Use the match method to limit the scope of URLs that your scraper will apply to.

Your new attribute is now available for use:

    Earl['http://www.quotationspage.com/qotd.html'].qotd
    => "Love is a snowmobile racing across the tundra and then suddenly it flips over, pinning you underneath. At night, the ice weasels come."

### How do I install it for normal use?

If using bundler, add gem 'earl' your application's Gemfile and run `bundle`.

Or install it from the command-line:

    gem install earl

### How do I install it for gem development?

To work on enhancements of fix bugs in Earl, fork and clone the github repository.
If you are using bundler (recommended), run `bundle` to install development dependencies:

    gem install bundler
    bundle

### How do I run the tests?

Once development dependencies are installed, all unit tests are run with just:

    $ rake
    # or..
    $ rake spec

VCR is used to record integration tests. To re-record sessions, delete the corresponding cassette in
[spec/fixtures/cassettes](./spec/fixtures/cassettes/).

### How do I automatically run tests when I modify files?

Guard is installed as part of the development dependencies. Start a guard process in a terminal window:

    bundle exec guard

It will run all the tests to start with by default. Then whenever you change a file, the associated tests will execute in this terminal window.

## Contributing to Earl

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

See [LICENSE](./LICENSE) for details.
