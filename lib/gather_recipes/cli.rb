require "pry"
class GatherRecipes::CLI
    def call
        puts "Welcome to Gather!"
        @input = ""
        until @input == "exit"
            get_categories
            list_categories
            get_user_category
            next_option
        end
        bye
    end

    def get_categories
       @categories = GatherRecipes::Category.all
    end

    def list_categories
        puts "Choose a category to see recipes:"
        @categories.each.with_index(1) do |category, index|
            puts "#{index}. #{category.name}"
        end
    end

    def get_user_category
        category_input = gets.strip.to_i
        show_recipes_for(category_input) if valid_input(category_input, @categories)
    end

    def valid_input(input, data)
        input.to_i <= data.length && input.to_i > 0
    end

    def show_recipes_for(category_input)
        category = @categories[category_input - 1]
        category.get_recipes 
        puts "Here are the recipes for #{category.name}:"
        category.recipes.each.with_index(1) do |recipe, index|
            puts "#{index}. #{recipe.name}"
        end
        get_user_recipe(category)
    end

    def get_user_recipe(category)
        puts "Choose a recipe to see more details"
        input = gets.strip
        recipe = category.recipes[input.to_i - 1]
        recipe.get_recipe_measurements
        show_recipe_measurements(recipe)
    end

    def show_recipe_measurements(recipe)
        puts recipe.name
        recipe.measurements.each do |i|
            puts "- #{i}"
        end
    end


    def next_option
        puts "If you are done, type 'exit' to end the program. Hit any key to continue."
        @input = gets.strip
    end

    def bye
        puts "See you later!"
    end

end
