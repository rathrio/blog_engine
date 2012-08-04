require 'ostruct'
require 'time'
require 'yaml'

module ArticleParser
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def file_to_article(filename)
      meta, content   = File.read(filename).split("\n\n", 2)
      article_struct meta, content, filename
    end

    def write_article(attributes)
      filename = "#{root}/articles/#{Time.now.to_i}.md"
      date = attributes[:date].empty? ? Date.today.to_s : attributes[:date]
      meta = "title: #{attributes[:title]}\n" +
             "author: #{attributes[:author]}\n" +
             "date: #{date}\n\n"
      content = attributes[:content]
      File.open(filename, "w") { |file| file.write meta + content }
      article_struct meta, content, filename
    end
    
    private
    
      def article_struct(meta, content, filename)
        article         = OpenStruct.new YAML.load(meta)
        article.date    = Time.parse article.date.to_s
        article.content = content
        article.slug    = File.basename(filename, '.md')
        article
      end
  end
  
  def file_to_article(file)
    self.class.file_to_article file
  end
  
  def write_article(attributes)
    self.class.write_article attributes
  end
  
end