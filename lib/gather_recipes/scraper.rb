
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
        if category.name == "Healthy-ish" || category.name == "Vegetarian"
            url = "https://www.halfbakedharvest.com/category/recipes/diet-specific/#{category.name}/"
            page = Nokogiri::HTML(open(url))
        
            recipes = page.css("a.recipe-block")
        
            recipes.each do |r|
                name = r.css("span")[1].text.strip.chomp(".")
                url = r.attribute('href')
                GatherRecipes::Recipe.new(name, category, url)
            end

        elsif
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
        puts "#{recipe.name}:".bold
        recipe_ingredients = page.css("ul.wprm-recipe-ingredients li")
        recipe_ingredients.each do |i|
            amount = i.css("span.wprm-recipe-ingredient-amount").text.strip
            unit = i.css("span.wprm-recipe-ingredient-unit").text.strip
            name = i.css("span.wprm-recipe-ingredient-name").text.strip
            recipe.measurements << amount << unit << name
            puts "\u2767 #{amount} #{unit} #{name}"
        end
    end

    def self.scrape_recipe(recipe)
        url = recipe.url
        page = Nokogiri::HTML(open(url))
        puts "#{recipe.name}:".bold
        full_recipe = page.css("ol.wprm-recipe-instructions li")[0]
        full_recipe.css("p").each do |i|
          puts i.text
        end
    end

end

        
        

       




