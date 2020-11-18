class GatherRecipes::Scraper

    def self.scrape_ingredients
        page = Nokogiri::HTML(open("https://www.loveandlemons.com/recipes/"))
        
        ingredients = page.css (
        "div.lnl-rb-ingredient")
        
        ingredients.each do |r|
          name = r.css('span.category-name').text.strip
          ref = r.attr("value")
          GatherRecipes::Ingredient.new(name, ref)
        end
    end
        
    end