class GatherRecipes::Scraper

    def self.scrape_categories
        page = Nokogiri::HTML(open("https://www.halfbakedharvest.com/category/recipes/"))
        
        categories = page.css("ul.children li")[11..14]
        
        categories.each do |c|
          name = c.css("a").text.strip
          ref = c.attr("value")
          GatherRecipes::Category.new(name, ref)
        end
    end


    def self.scrape_recipes(category)
        GatherRecipes::Recipe.new("yummy", category)
        GatherRecipes::Recipe.new("yucky", category)
        #url = "https://www.halfbakedharvest.com/category/recipes/diet-specific/#{category.ref}/"
        #page = Nokogiri::HTML(open(url))
        
        #recipes = page.css("a.recipe-block")
        
        #recipes.each do |r|
            #name = r.css("span")[1].text.strip.chomp(".")
            #url = r.css("a").attr("href")
            #GatherRecipes::Recipe.new(name, category)
        #end
    end
    
 end