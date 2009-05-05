$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
gem     'activesupport'
require 'activesupport'
gem     'tenderlove-nokogiri'
require 'nokogiri'
require 'open-uri'

require 'earl/scraper'
require 'earl/url'

require 'earl/youtube_scraper'
