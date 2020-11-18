class GatherRecipes::Recipe 
attr_accessor :name, :ingredient, :url
@@all = []

def initialize(name, url, ingredient)
    @name = name
    @url = url
    @ingredient = ingredient 
    save
end

def self.all
    @@all
end 

def save
    @@all << self
end

def self.get_recipe(ingredient)
    self.scrape_recipes(ingredient)
    recipe_index = CLI.display(self.type, category.recipes)
    recipe = category.recipes[recipe_index]
end



end
