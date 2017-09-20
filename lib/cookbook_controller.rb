require_relative 'cookbook_view.rb'
require_relative 'recipe.rb'
require_relative 'cookbook.rb'
require 'nokogiri'
require 'open-uri'

class CookbookController
  def initialize(file_path)
    @cookbook_view = CookbookView.new
    @cookbook = Cookbook.new(file_path)
  end
  def index
    recipes = @cookbook.all
    if recipes.empty?
      puts "there is nothing here!"
    else
      @cookbook_view.show_recipes(recipes)
    end
  end
  def create
    recipe_name = @cookbook_view.fetch_recipe_name
    @cookbook.create(recipe_name)
  end
  def delete
    i = @cookbook_view.fetch_recipe_index
    @cookbook.delete(i)
  end
  def import_xiachufang
    search_key = @cookbook_view.fetch_search_key
    url = "https://www.xiachufang.com/search/?keyword=#{search_key}&cat=1001"
    url=URI.escape(url) 
    results = parse_website(url)
    @cookbook_view.show_results(results)
    i = @cookbook_view.fetch_recipe_index
    @cookbook.create(results[i])
  end

  private
  def parse_website(url)
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    search_elements = doc.xpath("//ul[@class='list']/li/a/div[@class='info pure-u']/p[@class='name']")
    results = []
    search_elements.each do |e|
      results << e.text.strip
    end
    results
  end
end

