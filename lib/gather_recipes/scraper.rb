class GatherRecipes::Scraper

    def self.scrape_categories
        page = Nokogiri::HTML(open("https://www.halfbakedharvest.com/category/recipes/"))
        
        categories = page.css("ul.children li")[11..14]
        
        categories.each do |c|
          name = c.css("a").text
          ref = c.attr("value")
          GatherRecipes::Category.new(name, ref)
        end
    end


    def self.scrape_recipes(category)
        if category.name == "vegetarian" || category.name == "healthy-ish"
            url = "https://www.halfbakedharvest.com/category/recipes/diet-specific/#{category.name}/"
            page = Nokogiri::HTML(open(url))
        
            recipes = page.css("a.recipe-block")
        
         recipes.each do |r|
                name = r.css("span")[1].text.strip.chomp(".")
                url = r.css("a").attr("href")
                GatherRecipes::Recipe.new(name, category, url)
            end

        else 
            url = "https://www.halfbakedharvest.com/category/recipes/diet-specific/#{category.name}-recipes/"
            page = Nokogiri::HTML(open(url))
        
            recipes = page.css("a.recipe-block")
        
            recipes.each do |r|
                name = r.css("span")[1].text.strip.chomp(".")
                url = r.css("a").attr("href")
                GatherRecipes::Recipe.new(name, category, url)
            end
        end
    end
end
    