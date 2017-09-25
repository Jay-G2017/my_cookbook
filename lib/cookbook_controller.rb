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
  def empty?
    @cookbook.all.empty? ? true : false
  end
  def index
    recipes = @cookbook.all
    @cookbook_view.show_recipes_index(recipes)
  end
  def show
    index
    i = @cookbook_view.fetch_index_minus_one
    recipe = @cookbook.find(i)
    @cookbook_view.show_recipe_show(recipe)
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
    @cookbook_view.show_search_results_from_xiachufang(results)
    puts "选择你想导入的菜单号:"
    i = @cookbook_view.fetch_index_minus_one
    recipe = parse_website_detail(results[i]['url'])
    # binding.pry
    recipe['name'] = results[i]['name']
    recipe['score'] = results[i]['score']
    recipe['url'] = results[i]['url']
    @cookbook.create(recipe)
  end

  private
  def parse_website(url)
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    search_elements = doc.xpath('//div[@class="normal-recipe-list"]/ul/li/a')
    results = []
    base = 'https://www.xiachufang.com'
    binding.pry
    search_elements.each do |e|
      hash = {}
      hash['name'] = e.css('.name').text.strip
      hash['score'] = e.css('.score, .green-font').text.strip.to_f.round(1)
      hash['url'] = base + e['href']
      results << hash
    end
    results
  end

  def parse_website_detail(url)
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    results = {}

    ings = doc.css('div.ings table tr')
    ings_hash = {}
    ings.each do |ing|
      key = ing.css('td').first.text.strip
      value = ing.css('td').last.text.strip
      ings_hash[key] = value
    end
    results['ings'] = ings_hash
    
    steps = doc.css('div.steps ol li')
    steps_hash = {}
    steps.each do |step|
      key = step.text.strip
      step.at_css('img').nil? ? value = nil : value = step.at_css('img')['src']
      steps_hash[key] = value
    end
    results['steps'] = steps_hash

    unless doc.css('div.tip').empty?
      tips = []
      doc.css('div.tip').first.children.each do |child|
        tips << child.text.strip
      end
      results['tips'] = tips
    end
    results
  end
end

