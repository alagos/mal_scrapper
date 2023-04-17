# frozen_string_literal: true
require 'open-uri'
require 'nokogiri'
require 'json'
require 'faraday'
require 'pry'
require 'pry-byebug'

require_relative 'mal_scraper/init'
require_relative 'mal_scraper/episode'
require_relative 'mal_scraper/version'

module MalScraper
  class Error < StandardError; end
end
