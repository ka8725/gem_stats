require 'json'
require 'open-uri'

module GemStats
  class GemInfo
    API_URL = "https://rubygems.org/api/v1/gems/"
    REQUEST_FORMAT = 'json'

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def info
      return @info if defined?(@info)
      begin
        @info ||= JSON.load open("#{API_URL}#{@name}.#{REQUEST_FORMAT}").read
      rescue OpenURI::HTTPError => e
        @info = nil
      end
    end

    def dependencies(env = 'runtime')
      @dependencies ||= {}
      @dependencies[env.to_s] ||= info['dependencies'][env.to_s].inject([]) { |list, gem| list << gem['name'] }
    end

    def clients(env = 'runtime')
      Gem.where("dependencies.#{env}.name" => @name).all
    end

    def save
      gem = Gem.find_by_name(@name) || Gem.new
      if info
        gem.attributes = info
        gem.save
      else
        false
      end
    end
  end
end
