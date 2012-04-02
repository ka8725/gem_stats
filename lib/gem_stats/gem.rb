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

    %w(runtime development).each do |env|
      define_method "#{env}_dependencies" do
        dependencies[env]
      end
    end
  end
end
