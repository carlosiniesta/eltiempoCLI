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

    desc "av_max", "display today's temperature"
    def av_max city
      puts "Average maximum temperature of the week in #{city} " + @eltiempoparser.average_temp(city, "max").to_s + "º"
    end

    desc "av_min", "display today's temperature"
    def av_min city
      puts "Average maximum temperature of the week in #{city} " + @eltiempoparser.average_temp(city, "min").to_s + "º"
    end

    private

    def config
      @eltiempoparser = EltiempoParser.new
    end

    map "-today" => "today"
    map "-av_max" => "av_max"
    map "-av_min" => "av_min"

  end
end
