
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
                url = r.css("a").attr("href").value
                GatherRecipes::Recipe.new(name, category, url)
            end

        else 
            url = "https://www.halfbakedharvest.com/category/recipes/diet-specific/#{category.name}-recipes/"
            page = Nokogiri::HTML(open(url))
        
            recipes = page.css("a.recipe-block")
        
            recipes.each do |r|
                name = r.css("span")[1].text.strip.chomp(".")
                url = r.attribute('href')
                GatherRecipes::Recipe.new(name, category, url)
            end
        end
    end

    def self.scrape_ingredients(recipe)
        url = recipe.url
        page = Nokogiri::HTML(open(url))

        recipe_ingredients = page.css("ul.wprm-recipe-ingredients li")

        recipe_ingredients.each do |i|
            amount = i.css("span.wprm-recipe-ingredient-amount").text.strip
            #unit = i.css("span.wprm-recipe-ingredient-unit").text.strip
            #name = i.css("span.wprm-recipe-ingredient-name").text.strip
            recipe.measurements << amount
           

         end
        end
        

       

end
