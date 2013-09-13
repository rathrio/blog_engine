require 'ostruct'
require 'time'
require 'yaml'
require 'tag_list'

class Article < OpenStruct
  extend Conversions

  def self.from_file(filename)
    meta, content       = File.read(filename).split("\n\n", 2)
    content, misc       = split_misc_from_content content
    article             = new YAML.load(meta)
    article.date        = Time.parse article.date.to_s
    article.content     = content
    article.misc        = misc
    article.slug        = File.basename(filename, '.md')
    article.author_slug = article.author.downcase # TODO: #underscore
    article.tags        = TagList(article.tags)
    article
  end

  def self.split_misc_from_content(content)
    content.split /\n\n\/\/(NOTES|NOTE|OUTLINE|MISC)\/\/\n\n/, 2
  end
end
