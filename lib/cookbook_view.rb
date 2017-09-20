class CookbookView
  def show_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe.name}"  
    end
  end

  def show_results(results)
    results.each_with_index do |result, i|
      puts "#{i + 1}. #{result}"
    end
  end

  def fetch_recipe_name
    print ">"
    puts "Please type the recipe name"
    name = gets.chomp
  end
  def fetch_recipe_index
    print ">"
    puts "enter the index of recipe!"
    i = gets.chomp.to_i - 1
  end
  def fetch_search_key
    print ">"
    puts "what recipe do you want to search?"
    key = gets.chomp
  end
end

#CookbookView.new.fetch_recipe_name
