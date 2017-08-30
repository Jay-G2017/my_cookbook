def run(cookbook_controller)
  puts "** Welcome to Jay's CookBook ! **"
  puts "** The world's best easy to use cookbook! **"
  i = 0
  while i != 3 do 
    puts "Here's the recipe you have:"
    cookbook_controller.index
    puts "press [1] to create a new recipe"
    puts "press [2] to delete a recipe"
    puts "press [3] to exit!"
    print ">"
    i = gets.chomp.to_i

    case i
    when 1
      cookbook_controller.create
    when 2
      cookbook_controller.delete
    when 3

    else
      puts "try again....."
    end
  end

  puts "Bye bye..! Welcome to come again"
end
