class CookbookView
  def show_recipes_index(recipes)
    if recipes.empty?
      puts "there is nothing here!"
    else
      recipes.each_with_index do |recipe, index|
        puts "#{index + 1}. [#{recipe.score.empty? ? "未评": recipe.score}分] #{recipe.name}"
      end
    end
  end

  def show_recipe_show(recipe)
    print `clear`
    puts "#{recipe.name}"
    puts ""
    puts "用料:"
    recipe.ings.each do |ing, amount|
      puts " #{ing}: #{amount}"
    end
    puts ""
    puts "步骤:"
    recipe.steps.each_with_index do |(step, pic), i|
      puts " #{i + 1}: #{step}"
    end
    puts ""
    puts "小贴士:"
    recipe.tips.each do |tip|
      puts tip
    end
    puts ""
  end

  def steps_for_show
    puts "press [1] to see other recipe"
    puts "press [other keys] to go back"
  end

  def show_search_results_from_xiachufang(results)
    results.each_with_index do |result, i|
      puts "#{i + 1}. #{result['name']} [#{result['score']}分]"
      puts result['url']
    end
  end

  def fetch_recipe_info
    recipe_variables = Recipe.new.instance_variables.map { |x| x[1..-1] }
    recipe_info = {}
    recipe_variables.each do |v|
      case v
      when 'ings'
        run = true
        ings_hash = {}
        while run do
          print '>'
          puts "输入用料（例如姜，豆腐等）"
          ing = gets.chomp
          puts "输入用量（例如500号，一包等）"
          amount = gets.chomp
          if ing.empty? || amount.empty?
            run = false 
          else
            ings_hash[ing] = amount
          end
        end
        recipe_info['ings'] = ings_hash
      when 'steps'
        run = true
        steps_hash = {}
        while run do
          print '>'
          puts "输入步骤"
          step = gets.chomp
          if step.empty?
            run = false 
          else
            steps_hash[step] = nil
          end
        end
        recipe_info['steps'] = steps_hash
      when 'tips'
        run = true
        tips_array = []
        while run do
          print '>'
          puts "输入小贴士"
          tip = gets.chomp
          tips_array << tip
          run = false if tip.empty?
        end
        recipe_info['tips'] = tips_array
      else
        print ">"
        puts "Please type the recipe #{v}"
        recipe_info[v] = gets.chomp
      end
    end
    recipe_info
  end
  def fetch_index
    print ">"
    puts "enter the index!"
    i = gets.chomp.to_i
  end
  def fetch_index_minus_one
    print ">"
    puts "enter the index!"
    i = gets.chomp.to_i - 1
  end
  def fetch_search_key
    print ">"
    puts "what recipe do you want to search?"
    key = gets.chomp
  end
end

#CookbookView.new.fetch_recipe_name
