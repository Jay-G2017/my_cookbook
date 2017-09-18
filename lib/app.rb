require_relative 'route.rb'
require_relative 'cookbook_controller.rb'
file_path = File.join(__dir__, 'recipes.json')
cookbook_controller = CookbookController.new(file_path)

Route.new(cookbook_controller).run
