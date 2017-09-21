class Recipe
  attr_accessor :name, :ingredients, :process, :tips, :rate
  def initialize(name = nil, ingredients = nil, process = nil, tips = nil, rate = nil)
    @name = name
    @ingredients = ingredients
    @process = process
    @tips = tips
    @rate = rate
  end
end

