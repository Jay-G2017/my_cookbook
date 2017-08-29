#What you need to do with this app
#1. show all the recipes 
#2. create a new recipe
#3. delete a recipe
#4. exit
#5. addtional function: edit a recipe.
require_relative 'cookbook_controller.rb'
cookbook_controller = CookbookController.new
puts "** Welcome to Jay's CookBook ! **"
puts "** The world's best easy to use cookbook! **"
i = 0
while i != 4 do 
  puts "What do you want to do?"
  puts "press 1 to: show all the recipes"
  puts "press 2 to: create a new recipe"
  puts "press 3 to: delete a recipe"
  puts "press 4 to: exit!"
  print ">"
  i = gets.chomp.to_i

  case i
  when 1
    cookbook_controller.index
  when 2
    cookbook_controller.create
  when 3
    puts "deleting a recipe....."
  else
    puts "try again....."
  end
end

puts "Bye!"
