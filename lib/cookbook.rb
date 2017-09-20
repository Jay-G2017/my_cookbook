require 'json'
require 'byebug'
class Cookbook
  def initialize(file_path)
    @file_path = file_path
    @recipes = []
    load
  end

  def find(index)
    @recipes[index]
  end

  def all
    @recipes
  end

  def delete(index)
    @recipes.delete_at(index)
    save!
  end

  def create(name)
    new_recipe = Recipe.new(name)
    @recipes << new_recipe
    save!
  end

  private

  def load
    serialized_recipes = File.read(@file_path)
    json_parse_recipes = JSON.parse(serialized_recipes)
    if json_parse_recipes["recipes"].nil?
      @recipes
    else
      json_parse_recipes["recipes"].each do |recipe|
        recipe_instance = Recipe.new
        recipe.each do |key, value|
          recipe_instance.send(:key) = value
        end
        @recipes << recipe_instance
      end
    end
  end

  def save!
    json_recipes = {}
    array = []
    @recipes.each do |recipe|
      hash = {}
      recipe.instance_variables.each do |variable|
        v = variable[1..-1]
        hash[v] = recipe.send(v)
      end
      array << hash
    end
    json_recipes["recipes"] = array
    File.open(@file_path, 'wb') do |file|
      file.write(JSON.generate(json_recipes))
    end
  end
end
