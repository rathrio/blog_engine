Gem::Specification.new do |s|
  s.name        = "blog_engine"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rathesan Iyadurai"]
  s.email       = ["support@fadendaten.ch"]
  s.homepage    = "http://www.fadendaten.ch"
  s.summary     = "Simple Blog Engine"
  s.description = "Simple Blog Engine"

  s.required_rubygems_version = ">= 1.3.6"

  # s.add_dependency "i18n", "~> 0.4"
  # s.add_dependency "json"

  s.add_development_dependency "sinatra", "~> 1.3.2"
  s.add_development_dependency "shotgun", "~> 0.9"
  s.add_development_dependency "thin", "~> 1.4.1"
  s.add_development_dependency "rdiscount", "~> 1.6.8"
  s.add_development_dependency "datamapper", "~> 1.2.0"
  s.add_development_dependency "sqlite3", "~> 1.3.6"
  s.add_development_dependency "dm-sqlite-adapter", "~> 1.2.0"
  s.add_development_dependency "guard-rspec",  "~> 0.7.0"
  

  s.requirements << "json"

  s.files =  Dir.glob("{lib}/**/*")
  s.require_path = "lib"
end