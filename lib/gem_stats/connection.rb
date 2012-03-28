module GemStats
  module Connection
    def self.connect
      MongoMapper.connection = Mongo::Connection.new('localhost')
      MongoMapper.database = 'gem_stats'
    end
  end
end
