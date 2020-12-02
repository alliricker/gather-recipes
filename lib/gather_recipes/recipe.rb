class GatherRecipes::Recipe 
    attr_accessor :name, :category, :url, :measurements
    @@all = []
    
    def initialize(name, category, url)
        @name = name
        @category = category
        @url = url
        @measurements = []
        add_to_category
        save
    end
    
    def self.all
        @@all
    end 
    
    def add_to_category
        @category.recipes << self unless @category.recipes.include?(self)
    end
    
    def get_recipe_measurements 
        GatherRecipes::Scraper.scrape_ingredients(self) if @measurements.empty?
    end

    def get_full_recipe
        GatherRecipes::Scraper.scrape_recipe(self) 
    end
    
    def save
        @@all << self
    end

end
    
