class Recipe
  attr_accessor :name, :process, :tip, :rate
  def initialize(name = nil, process = nil, tip = nil, rate = nil)
    @name = name
    @process = process
    @tip = tip
    @rate = rate
  end
end
