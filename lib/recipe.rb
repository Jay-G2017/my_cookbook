class Recipe
  attr_accessor :name, :process, :tip 
  attr_reader :rate
  def initialize(name)
    @name = name
  end
end
