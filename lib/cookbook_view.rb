class CookbookView
  def show_recipes_index(recipes)
    if recipes.empty?
      puts "现在还没有任何菜谱哦!"
      puts "创建一条或从爱厨房找找你喜欢的菜谱吧!"
    else
      recipes.each_with_index do |recipe, index|
        puts "#{index + 1}. #{recipe.name} [#{recipe.score.class == Float ? recipe.score : '未评'}分]"
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
    if recipe.tips
      puts "小贴士:"
      recipe.tips.each do |tip|
        puts tip
      end
      puts ""
    end
    if recipe.url
      puts "查看菜谱的原网址"
      puts "#{recipe.url}"
      puts ""
    end
  end

  def steps_for_show
    puts "按 [1] 看其它的菜谱"
    puts "按任何其它键返回"
  end

  def show_search_results_from_xiachufang(results)
    results.each_with_index do |result, i|
      puts "#{i + 1}. #{result['name']} [#{result['score']}分]"
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
        puts "输入菜谱的#{v}"
        value = gets.chomp
        value = value.to_i.round(1) if value.to_i != 0 
        recipe_info[v] = value
      end
    end
    recipe_info
  end
  def fetch_index
    print ">"
    puts "请选择序号!"
    i = gets.chomp.to_i
  end
  def fetch_index_minus_one
    print ">"
    puts "请选择序号!"
    i = gets.chomp.to_i - 1
  end
  def fetch_search_key
    print ">"
    puts "输入任何你想搜索的菜谱（比如'红烧肉'，'鱼香肉丝'等)"
    key = gets.chomp
  end
end

#CookbookView.new.fetch_recipe_name
