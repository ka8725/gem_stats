require 'rubygems/spec_fetcher'

module GemStats
  class Fetcher
    def self.list(all_versions = false, prerelease = false)
      @gem_list ||= ::Gem::SpecFetcher.new.list(all_versions, prerelease).values.flatten(1)
    end

    def self.list_names
      @list_name ||= list.map(&:first)
    end

    def self.fetch_and_safe
      threads = []
      list_names.each do |name|
        threads << Thread.new(name) { |name| GemInfo.new(name).save }
        if threads.count == 50
          threads.each(&:join)
          threads = []
        end
      end
    end
  end
end
