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
    @cookbook_view.show_recipes(recipes)
  end
  def show
    index
    i = @cookbook_view.fetch_index
    recipe = @cookbook.find(i - 1)
    @cookbook_view.show_recipe(recipe)
    @cookbook_view.steps_for_show
    i = @cookbook_view.fetch_index
    show if i == 1
  end

  def create
    recipe_info = @cookbook_view.fetch_recipe_info
    @cookbook.create(recipe_info)
  end
  def delete
    i = @cookbook_view.fetch_index
    @cookbook.delete(i - 1)
  end
  def import_xiachufang
    search_key = @cookbook_view.fetch_search_key
    url = "https://www.xiachufang.com/search/?keyword=#{search_key}&cat=1001"
    url=URI.escape(url)
    results = parse_website(url)
    @cookbook_view.show_results(results)
    i = @cookbook_view.fetch_index
    @cookbook.create(results[i - 1])
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

