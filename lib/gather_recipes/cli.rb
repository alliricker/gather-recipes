require "pry"
class GatherRecipes::CLI
    def call
        puts "Welcome to Gather!"
        until @input == "exit"
            get_ingredients
            list_ingredients
            get_user_ingredient
            get_user_recipe
            next_option
        end
        bye
    end

    def get_ingredients
       @ingredients = GatherRecipes::Ingredient.all
    end

    def list_ingredients 
        puts "Choose an ingredient to see recipes"
        @ingredients.each.with_index(1) do |ingredient, index|
            puts "#{index}. #{ingredient.name}"
        end
    end

    def get_user_ingredient
        ingredient_input = gets.strip .to_i
        show_recipes_for(ingredient_input) if valid_input(ingredient_input, @ingredients)
    end

    def valid_input(input, data)
        input.to_i <= data.length && input.to_i > 0
    end

    def show_recipes_for(ingredient_input)
        ingredient = @ingredients[ingredient_input - 1]
        ingredient.get_recipes 
        puts "Here are your recipes for #{ingredient.name}"
        ingredient.recipes.each.with_index(1) do |recipe, index|
            puts "#{index}. #{recipe.name}" 
        end
        get_user_recipe(ingredient)
    end

    def get_user_recipe(ingredient)
        puts "Choose a recipe for more details"
        input = gets.strip 
        recipe  = ingredient.recipes[input.to_i - 1]
        recipe.get_recipe_details
        show_recipe_details(recipe)
    end

    def show_recipe_details(recipe)
        puts recipe.name
        recipe.key_info.each { |i| puts "- #{1}"}
    end

    def next_option
        puts "If you are done, type 'exit' to end the program. Hit any key to continue."
        input = gets.strip
    end

    def bye
        puts "See you later!"
    end


end