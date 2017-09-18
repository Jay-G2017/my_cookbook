require_relative 'cookbook_view.rb'
require_relative 'recipe.rb'
require_relative 'cookbook.rb'

class CookbookController
  def initialize(file_path)
    @cookbook_view = CookbookView.new
    @cookbook = Cookbook.new(file_path)
  end
  def index
    recipes = @cookbook.all
    if recipes.empty?
      puts "there is nothing here!"
    else
      @cookbook_view.show_recipes(recipes)
    end
  end
  def create
    recipe_name = @cookbook_view.fetch_recipe_name
    @cookbook.create(recipe_name)
  end
  def delete
    i = @cookbook_view.fetch_recipe_index
    @cookbook.delete(i)
  end
end

