require 'ostruct'
require 'time'
require 'yaml'
require 'tag_list'

class Article < OpenStruct
  extend Conversions

  def self.from_file(filename)
    meta, content       = File.read(filename).split("\n\n", 2)
    article             = new YAML.load(meta)
    article.content     = content
    article.date        = Time.parse article.date.to_s
    article.slug        = File.basename(filename, '.md')
    article.author_slug = article.author.downcase # TODO: #underscore
    article.tags        = TagList(article.tags)
    article
  end
end
