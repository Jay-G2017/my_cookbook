class Cookbook
  def initialize(file_path)
    @recipes = []
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

  def create
    @recipes << self
  end

  def save
    save to the file_path
  end
end
