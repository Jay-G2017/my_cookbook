def run(cookbook_controller)
  print `clear`
  puts "** Welcome to Jay's CookBook ! **"
  puts "** The world's best easy to use cookbook! **"
  puts "          ------------------       "
  i = 0
  while i != 3 do
    print `clear` if i != 0
    puts "Here's the recipe you have:"
    cookbook_controller.index
    puts ""
    puts "press [1] to create a new recipe"
    puts "press [2] to delete a recipe"
    puts "press [3] to exit!"
    print ">"
    i = gets.chomp.to_i

    case i
    when 1
      print `clear`
      cookbook_controller.create
    when 2
      print `clear`
      cookbook_controller.index
      puts ""
      cookbook_controller.delete
    when 3

    else
      puts "try again....."
    end
  end

  puts "Bye bye..! Welcome to come again"
end
