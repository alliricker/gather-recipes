class GatherRecipes::Scraper

    def self.scrape_ingredients
        site = "https://www.loveandlemons.com/recipes/"
        page = Nokogiri::HTML(open(site))
        
        ingredients = page.css (
        "div.lnl-rb-ingredient")
        
        ingredients.each do |r|
          name = r.css('span.category-name').text.strip
          ref = r.attr("value")
          GatherRecipes::Ingredient.new(name, ref)
        end
        
    end