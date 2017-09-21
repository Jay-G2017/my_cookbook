class CookbookView
  def show_recipes(recipes)
    if recipes.empty?
      puts "there is nothing here!"
    else
      recipes.each_with_index do |recipe, index|
        puts "#{index + 1}. [#{recipe.rate ? recipe.rate : "未评"}分] #{recipe.name}"
      end
    end
  end

  def show_recipe(recipe)
    print `clear`
    puts "Name: #{recipe.name}"
    puts "ingredients:"
    puts "#{recipe.ingredients}"
    puts "Process:"
    puts "#{recipe.process}"
    puts "Tips:"
    puts "#{recipe.tips}"
  end

  def steps_for_show
    puts "press [1] to see other recipe"
    puts "press [other keys] to go back"
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
  def fetch_index
    print ">"
    puts "enter the index!"
    i = gets.chomp.to_i
  end
  def fetch_search_key
    print ">"
    puts "what recipe do you want to search?"
    key = gets.chomp
  end
end

#CookbookView.new.fetch_recipe_name
