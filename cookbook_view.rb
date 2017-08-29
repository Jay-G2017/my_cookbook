class CookbookView
  def show_recipes(recipes)
    recipes.each_with_index do |recipe|
      puts "#{index}. recipe.name"  
    end
  end

  def fetch_recipe_name
    print ">"
    puts "Please type the recipe name"
    name = gets.chomp
  end
end
