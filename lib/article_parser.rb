require 'ostruct'
require 'time'
require 'yaml'

module ArticleParser
  
  def file_to_article(file)
    meta, content   = File.read(file).split("\n\n", 2)
    article         = OpenStruct.new YAML.load(meta)
    article.date    = Time.parse article.date.to_s
    article.content = content
    article.slug    = File.basename(file, '.md')
    article
  end
  
end