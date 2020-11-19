class GatherRecipes::Category
    attr_accessor :name , :ref, :recipes
    @@all = []

    def initialize (name, ref)
        @name = name
        @ref = ref
        @recipes = []
        save
    end

    def self.all
        GatherRecipes::Scraper.scrape_categories if @@all.empty?
        @@all
    end

    def get_recipes
        GatherRecipes::Scraper.scrape_recipes(self) if @recipes.empty?
    end

    def save
        @@all << self
    end
end
