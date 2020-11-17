class GatherRecipes::Ingredient
    attr_accessor :name 
    @@all = []

    def initialize (name)
        @name = name
        save
    end

    def self.all
        GatherRecipes::Scraper.scrape_ingredients 
        @@all
    end

    def get_recipes
        GatherRecipes::Scraper.scrape_recipes(self) if @recipes.empty?
    end

    def save
        @@all << self
    end
end
