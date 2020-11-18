class GatherRecipes::Recipe 
attr_accessor :name, :ingredient
@@all = []

def initialize(name, ingredient)
    @name = name
    @ingredient = ingredient 
    add_to_ingredient
    save
end

def self.all
    @@all
end 

def add_to_ingredient
    @ingredient.recipes << self unless @ingredient.recipes.include?(self)
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
