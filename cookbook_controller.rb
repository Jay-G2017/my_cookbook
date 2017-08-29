require_relative 'cookbook_view.rb'
require_relative 'recipe.rb'
class CookbookController
  @recipes = []
  @cookbook_view = CookbookView.new
  def index
    if @recipes.nil?
      puts "there is nothing here!"
    else
      @cookbook_view.show_recipes(@recipes)
    end
  end
  def create
    @cookbook_view.fetch_recipe_name
    new_recipe = Recipe.new(name)
    @recipes << new_recipe
    puts "a new recipe saved!"
  end
end
