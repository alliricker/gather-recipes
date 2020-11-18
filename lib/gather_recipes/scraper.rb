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

    def self.scrape_recipes(ingredient)
        page = Nokogiri::HTML(open("https://www.loveandlemons.com/recipes/"))
        
        recipes = page.css("ol.rb-items li")
        
        recipes.find do |i|
            name = i.css('div.thumbnail_text_content').text.strip
            GatherRecipes::Recipe.new(name, ingredient)
        end
    end
    


        
    end