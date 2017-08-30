require 'json'
class Recipe
  attr_accessor :name, :description
  def initialize(name)
    @name = name
  end
end
