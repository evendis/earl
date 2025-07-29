# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'json'
require 'oembed'

OEmbed::Providers.register_all

class Earl
end

require 'earl/version'
require 'earl/scraper'
require 'earl/earl'
