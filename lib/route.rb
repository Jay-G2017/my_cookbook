class Route
  def initialize(cookbook_controller)
    @cookbook_controller = cookbook_controller
    @running = true
  end

  def run
    welcome_message
    # binding.pry
    while @running
      show_recipes_and_todo_list
      action = gets.chomp.to_i
      route_action(action)
    end
    bye_message
  end

  private
  def welcome_message
    print `clear`
    puts "**** 欢迎使用杰氏菜谱 ! ****"
    puts "*** 简单好用的私人菜谱! ***"
    puts "  ***                ***"
    puts "    ------------------     "
  end

  def bye_message
    puts "欢迎再次使用....再见！"
  end

  def show_recipes_and_todo_list
    # print `clear` if @running
    puts "以下是你的菜谱列表："
    @cookbook_controller.index
    puts ""
    puts "按 [1] 查看你的菜谱" unless @cookbook_controller.empty?
    puts "按 [2] 从'下厨房'导入你喜欢的菜谱"
    puts "按 [3] 创建你自己的菜谱"
    puts "按 [4] 删除菜谱!"
    puts "按 [5] 退出软件"
    print ">"
  end

  def route_action(action)
    case action
    when 1
      if @cookbook_controller.empty?
        puts "现在没有菜谱，您不能查看，请按其它键来添加菜谱！"
      else
        print `clear`
        @cookbook_controller.show
        print `clear`
      end
    when 2
      print `clear`
      @cookbook_controller.import_xiachufang
      print `clear`
    when 3
      print `clear`
      @cookbook_controller.create
      print `clear`
    when 4
      print `clear`
      @cookbook_controller.index
      puts ""
      @cookbook_controller.delete
      print `clear`
    when 5
      print `clear`
      bye_message
      exit
    else
      puts "喔..你按的键不对！"
      puts "请按1-5！"
    end
  end

end
