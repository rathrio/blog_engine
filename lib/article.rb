require 'ostruct'
require 'time'
require 'yaml'

class Article < OpenStruct
  def self.from_file(filename)
    meta, content   = File.read(filename).split("\n\n", 2)
    article         = new YAML.load(meta)
    article.date    = Time.parse article.date.to_s
    article.content = content
    article.slug    = File.basename(filename, '.md')
    article
  end

  def author_slug
    # TODO: #underscore
    author.downcase
  end
end
