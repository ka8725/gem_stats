require 'rubygems/spec_fetcher'
require 'progressbar'

module GemStats
  class Fetcher
    @@bulk_number = 50
    cattr_accessor :bulk_number

    def self.list(all_versions = false, prerelease = false)
      @gem_list ||= ::Gem::SpecFetcher.new.list(all_versions, prerelease).values.flatten(1)
    end

    def self.list_names
      @list_name ||= list.map(&:first)
    end

    def self.fetch_and_safe
      pbar = ProgressBar.new("Fetching gems", list.count)
      pbar.bar_mark = '#'
      threads = []
      list_names.each_with_index do |name, index|
        threads << Thread.new(name) { |name| GemInfo.new(name).save }
        if threads.count == @@bulk_number
          threads.each(&:join)
          threads = []
          pbar.inc(bulk_number)
        end
      end
      pbar.finish
    end
  end
end
