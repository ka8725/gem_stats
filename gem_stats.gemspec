# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gem_stats/version"

Gem::Specification.new do |s|
  s.name        = "gem_stats"
  s.version     = GemStats::VERSION
  s.authors     = ["Andrey Koleshko"]
  s.email       = ["ka8725@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Fetch full statistic for the given gem name}
  s.description = %q{Just put gemstats your_gem_name and have a pleasure to see full statistic for this gem}

  s.rubyforge_project = "gem_stats"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "mongo_mapper"
  s.add_runtime_dependency "bson_ext"
end
