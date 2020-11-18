require_relative "./gather_recipes/version"
require_relative "./gather_recipes/cli"
require_relative "./gather_recipes/ingredients"
require_relative "./gather_recipes/scraper"

require "pry"
require "nokogiri"
require 'open-uri'

module GatherRecipes
  class Error < StandardError; end
  # Your code goes here...
end
