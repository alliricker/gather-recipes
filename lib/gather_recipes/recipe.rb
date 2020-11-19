class GatherRecipes::Recipe 
attr_accessor :name, :category
@@all = []

def initialize(name, category)
    @name = name
    @category = category
    add_to_category
    save
end

def self.all
    @@all
end 

def add_to_category
    @category.recipes << self unless @category.recipes.include?(self)
end

def save
    @@all << self
end

end
