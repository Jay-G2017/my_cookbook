class CookbookView
  def show_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. [#{recipe.rate ? recipe.rate : "未评"}分] #{recipe.name}"  
    end
  end

  def show_results(results)
    results.each_with_index do |result, i|
      puts "#{i + 1}. #{result}"
    end
  end

  def fetch_recipe_info
    recipe_variables = Recipe.new.instance_variables.map { |x| x[1..-1] }
    recipe_info = {}
    recipe_variables.each do |v|
      print ">"
      puts "Please type the recipe #{v}"
      recipe_info[v] = gets.chomp
    end
    recipe_info
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
