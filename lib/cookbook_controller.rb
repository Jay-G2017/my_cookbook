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
    i = @cookbook_view.fetch_index_minus_one
    recipe = @cookbook.find(i)
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
    i = @cookbook_view.fetch_index_minus_one
    @cookbook.delete(i)
  end
  def import_xiachufang
    search_key = @cookbook_view.fetch_search_key
    url = "https://www.xiachufang.com/search/?keyword=#{search_key}&cat=1001"
    url=URI.escape(url)
    results = parse_website(url)
    @cookbook_view.show_results(results)
    puts "选择你想导入的菜单号:"
    i = @cookbook_view.fetch_index_minus_one
    @cookbook.create(results[i])
  end

  private
  def parse_website(url)
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    search_elements = doc.xpath('//div[@class="normal-recipe-list"]/ul/li/a')
    results = []
    base = 'https://www.xiachufang.com'
    search_elements.each do |e|
      hash = {}
      hash['name'] = e.css('.name').text.strip
      hash['score'] = e.css('.score, .green-font').text.strip
      hash['url'] = base + e['href']
      results << hash
    end
    results
  end

  def parse_website_detail(url)
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    elements = doc.xpath('')
end

