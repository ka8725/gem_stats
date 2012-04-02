require 'mongo_mapper'

module GemStats
  class Gem
    include MongoMapper::Document

    key :name, String
    key :dependencies, Hash
    key :version, String
    key :downloads, Integer
    key :version_downloads, String
    key :authors, String
    key :info, String
    key :project_uri, String
    key :gem_uri, String
    key :homepage_uri, String
    key :wiki_uri, String
    key :documentation_uri, String
    key :mailing_list_uri, String
    key :source_code_uri, String
    key :bug_tracker_uri, String

    # to generate pretty url for rails
    def to_param
      name
    end

    def gem_info
      @gem_info ||= GemInfo.new(name)
    end

    %w(runtime development).each do |env|
      define_method "#{env}_dependencies" do
        dependencies[env]
      end

      define_method "#{env}_dependents" do
        eval "@#{env}_dependents ||= gem_info.clients('#{env}')"
      end
    end
  end
end
