require_relative 'cookbook_view.rb'
require_relative 'recipe.rb'
require 'json'

class CookbookController
  def initialize
    serialized_recipes = File.read('recipes.json')
    @recipes = JSON.parse(serialized_recipes)
    @cookbook_view = CookbookView.new
  end
  def index
    if @recipes.empty?
      puts "there is nothing here!"
    else
      @cookbook_view.show_recipes(@recipes)
    end
  end
  def create
    new_recipe = Recipe.new(@cookbook_view.fetch_recipe_name)
    hash = {}
    new_recipe.instance_variables.each do |v|
      v = v.to_s
      v[0] = ''
      hash[v] = new_recipe.send v
    end
    @recipes << hash
    File.open('recipes.json', 'wb') do |file|
      file.write(JSON.generate(@recipes))
    end
    puts "a new recipe saved!"
  end
  def delete
    index
    i = @cookbook_view.fetch_recipe_index
    @recipes.delete_at(i)
    File.open('recipes.json', 'wb') do |file|
      file.write(JSON.generate(@recipes))
    end
  end
end

#CookbookController.new.create
