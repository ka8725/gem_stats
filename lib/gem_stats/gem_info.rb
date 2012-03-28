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
      @info ||= JSON.load open("#{API_URL}#{@name}.#{REQUEST_FORMAT}").read
    end

    def dependencies(env = 'runtime')
      @dependencies ||= {}
      @dependencies[env.to_s] ||= info['dependencies'][env.to_s].inject([]) { |sum, gem| sum << gem['name'] }
    end

    def clients(env = 'runtime')
      Gem.where("#{env}_dependencies" => @name).all
    end

    def save
      log @name
      gem = Gem.find_by_name(@name) || Gem.new
      gem.attributes = {:name                     => @name,
                        :runtime_dependencies     => dependencies,
                        :development_dependencies => dependencies('development'),
                        :version                  => info['version'],
                        :downloads                => info['downloads'],
                        :version_downloads        => info['version_downloads'],
                        :authors                  => info['authors'],
                        :info                     => info['info'],
                        :project_uri              => info['project_uri'],
                        :gem_uri                  => info['gem_uri'],
                        :homepage_uri             => info['homepage_uri'],
                        :wiki_uri                 => info['wiki_uri'],
                        :documentation_uri        => info['documentation_uri'],
                        :mailing_list_uri         => info['mailing_list_uri'],
                        :source_code_uri          => info['source_code_uri'],
                        :bug_tracker_uri          => info['bug_tracker_uri']}
      gem.save
    end

    def log(message)
      puts message
    end
  end
end
