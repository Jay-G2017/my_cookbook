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
    puts "** Welcome to Jay's CookBook ! **"
    puts "** The world's best easy to use cookbook! **"
    puts "          ------------------       "
  end

  def bye_message
    puts "Bye bye..! Welcome to come again"
  end

  def show_recipes_and_todo_list
      # print `clear` if @running
      puts "Here's the recipes you have:"
      @cookbook_controller.index
      puts ""
      puts "press [1] to create a new recipe"
      puts "press [2] to delete a recipe"
      puts "press [3] to import recipes from 下厨房"
      puts "press [4] to exit!"
      puts "press [5] to show detail of the recipe"
      print ">"
  end

  def route_action(action)
      case action
      when 1
        print `clear`
        @cookbook_controller.create
        print `clear`
      when 2
        print `clear`
        @cookbook_controller.index
        puts ""
        @cookbook_controller.delete
        print `clear`
      when 3
        print `clear`
        @cookbook_controller.import_xiachufang
        print `clear`
      when 4
        @running = false
      when 5
        print `clear`
        @cookbook_controller.show
        print `clear`
      else
        puts "try again....."
      end
  end

end
