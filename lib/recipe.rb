class Recipe
  attr_accessor :name, :ings, :steps, :tips, :score, :url
  def initialize(name = nil, ings = nil, steps = nil, tips = nil, score = nil)
    @name = name
    @ings = ings
    @steps = steps
    @tips = tips
    @score = score
  end
end

