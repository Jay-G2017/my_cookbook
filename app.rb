require_relative 'route.rb'
require_relative 'cookbook_controller.rb'
file_path = 'recipes.json'
cookbook_controller = CookbookController.new(file_path)
run(cookbook_controller)
