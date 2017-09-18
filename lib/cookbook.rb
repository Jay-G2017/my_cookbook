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
      @recipes << Recipe.new(recipe["name"])
    end
    end
  end

  def save!
    json_recipes = {}
    array = []
    @recipes.each do |r|
      hash = {}
      hash[:name] = r.name
      array << hash
    end
    json_recipes["recipes"] = array
    File.open(@file_path, 'wb') do |file|
      file.write(JSON.generate(json_recipes))
    end
  end
end
