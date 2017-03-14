require 'thor'

module Eltiempo

  class EltiempoCLI < Thor

    def initialize(*args)
       super
       config
    end

    def self.exit_on_failure?
      true
    end

    desc "today", "display today's temperature"
    def today city
      puts "Temperature in #{city} " + @eltiempoparser.today_temp(city).to_s
    end

    desc "av_max", "display week average maximun temperature in city"
    def av_max city
      puts "Average maximum temperature of the week in #{city} " + @eltiempoparser.average_temp(city, "max").to_s + "º"
    end

    desc "av_min", "display week average minimun temperature in city"
    def av_min city
      puts "Average minimun temperature of the week in #{city} " + @eltiempoparser.average_temp(city, "min").to_s + "º"
    end

    desc "cities", "display names of all available cities"
    def cities
      puts @eltiempoparser.all_cities
    end

    private

    def config
      @eltiempoparser = EltiempoParser.new
    end

    map "-today" => "today"
    map "-av_max" => "av_max"
    map "-av_min" => "av_min"
    map "-cities" => "cities"

  end
end
