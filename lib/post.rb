require 'ostruct'
require 'time'
require 'yaml'
require 'tag_list'

class Post < OpenStruct
  extend Conversions

  class << self
    # Since we only have a few subclasses, we don't necessarily need a
    # descendants tracker. We just hard code them.
    def types
      [Article, Note, Recipe, BlissManifesto]
    end

    def sort_all!
      all.sort_by! { |post| post.date }
      all.reverse!
    end

    # As you may see, irregular purals are not support per se. Method needs to
    # be overriden if that's the case.
    def type_slug
      to_s.downcase + 's'
    end

    def from_file(filename)
      meta, content    = File.read(filename).split("\n\n", 2)
      post             = new YAML.load(meta)
      post.content     = content
      post.date        = Time.parse post.date.to_s
      post.slug        = File.basename(filename, '.md')
      post.author_slug = post.author.downcase # TODO: #underscore
      post.tags        = TagList(post.tags)
      post
    end

    def all
      @all ||= []
    end

    def tags
      @tags ||= TagList([])
    end

    def tags=(tags)
      @tags = tags
    end

    def by_author(author)
      all.select { |p| p.author == author }
    end

    def tagged(tag)
      all.select { |p| p.tags.to_a.include? tag }
    end
  end

  def publish
    register_tags
    save
  end

  def type_slug
    self.class.type_slug
  end

  private

  def register_tags
    self.class.tags = self.class.tags + tags
  end

  def save
    self.class.all << self
  end
end

Article = Class.new(Post)
Note    = Class.new(Post)
Recipe  = Class.new(Post)

class BlissManifesto < Post
  def self.sort_all!
    all.sort_by! { |post| post.date }
  end

  def self.type_slug
    "bliss_manifesto"
  end
end
