require 'ostruct'
require 'time'
require 'yaml'
require 'tag_list'

class Post < OpenStruct
  extend Conversions

  def self.from_file(filename)
    meta, content    = File.read(filename).split("\n\n", 2)
    post             = new YAML.load(meta)
    post.content     = content
    post.date        = Time.parse post.date.to_s
    post.slug        = File.basename(filename, '.md')
    post.author_slug = post.author.downcase # TODO: #underscore
    post.tags        = TagList(post.tags)
    post
  end

  def self.all
    @all ||= []
  end

  def self.by_author(author)
    all.select { |p| p.author == author }
  end

  def self.tagged(tag)
    all.select { |p| p.tags.to_a.include? tag }
  end

  def publish
    self.class.all << self
  end
end

class Article < Post
end

class Note < Post
end

class Recipe < Post
end
