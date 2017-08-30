require 'json'
class Cookbook
  def initialize(file_path)
    @file_path = file_path
    serialized_recipes = File.read(@file_path)
    @recipes = JSON.parse(serialized_recipes)
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
    hash = {}
    new_recipe.instance_variables.each do |v|
      v = v.to_s[1..-1]
      hash[v] = new_recipe.send v
    end
    @recipes << hash
  end

  def save!
    File.open(@file_path, 'wb') do |file|
      file.write(JSON.generate(@recipes))
    end
  end
end
