require 'open-uri'
require 'nokogiri'

class EltiempoParser

  attr_reader :api_key, :urlcities

  def initialize(api_key = "zdo2c683olan")
    @urlcities = {}
    @api_key = api_key

    url = "http://api.tiempo.com/index.php?api_lang=es&provincia=2&affiliate_id=" + @api_key
    nokogiri_parse = Nokogiri::XML(open(url))

    nokogiri_parse.xpath('//data').each do |city|
      @urlcities.store(city.xpath("name").text, city.xpath("url").text)
    end
  end


  def average_temp(city, value = "max")
    value == "max"? value = "Temperatura máxima" : value = "Temperatura mínima"
    doc = fetch_city_doc(city)
    element = doc.xpath("//var[./name[contains(text(),'#{value}')]]")
    counter = 0

    element.xpath('data/forecast').each do |temp|
      counter += temp.attribute("value").text.to_i
    end

    counter / 7
  end

  def today_temp city
    doc = fetch_city_doc(city)
    prediction_url = doc.xpath("//url").text
    html_scraper = Nokogiri::HTML(open(prediction_url))

    html_scraper.css('dd.ddTemp').text
  end

  def all_cities
    urlcities.keys
  end

  private

  def fetch_city_doc city
    unless urlcities[city]
      raise Thor::Error, "Error: #{city} city not found"
    end
    Nokogiri::XML(open(urlcities[city] + "&affiliate_id=" + api_key))
  end

end
