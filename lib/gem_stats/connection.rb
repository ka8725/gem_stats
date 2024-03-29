require 'erb'

module GemStats
  module Connection
    def self.connect(options = {})
      if options.empty?
        env, path = defined?(Rails)? [Rails.env, [Rails.root, 'config/database.yml']] :
          [ENV['ENV'] || 'development', File.expand_path('../../../config/database.yml', __FILE__)]
        get_config(path) {|config| MongoMapper.setup(config, env) }
      else
        MongoMapper.setup(options[:config], options[:env])
      end
    end

    def self.get_config(*path)
      yield YAML::load(ERB.new(File.read File.join(path)).result)
    end
  end
end
