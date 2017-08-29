class CookbookView
  def show_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. #{recipe["name"]}"  
    end
  end

  def fetch_recipe_name
    print ">"
    puts "Please type the recipe name"
    name = gets.chomp
  end
  def fetch_recipe_index
    print ">"
    puts "enter the index of recipe you want to delete!"
    i = gets.chomp.to_i - 1
  end
end

#CookbookView.new.fetch_recipe_name
