require 'sinatra/base'
require 'post'
require 'html_with_pygments'
require 'cache'

class Blog < Sinatra::Base
  use Cache if production?

  configure :production, :development do
    enable :logging
  end

  set :root, File.expand_path('../../', __FILE__)

  set :authors, []
  set :markdown, :renderer => HTMLwithPygments,
    :fenced_code_blocks => true, :layout_engine => :erb

  # Parses all markdown files for given Post class, converts them to `Post`s and
  # generates a `GET` route to display the post.
  #
  # If the Post class is named "Article", this method expects the files to be
  # in a directory named "articles".
  def self.parse_and_define_routes_for(post_class, path)
    Dir.glob path do |filename|
      post = post_class.from_file filename
      post.publish
      authors << post.author_slug

      # Generating routes for single post.
      # e.g. /articles/how_i_met_fuetzgue
      get "/#{post_class.pluralized_type_s}/#{post.slug}" do
        erb :post, :locals => { :post => post }
      end
    end

    # Sorting
    post_class.all.sort_by! { |post| post.date }
    post_class.all.reverse!
  end

  def self.define_tag_routes_for(post_class)
    post_class.tags.each do |tag|
      get "/#{post_class.pluralized_type_s}/tags/#{tag}" do
        posts = post_class.tagged tag
        erb :index, :locals => { :posts => posts }
      end
    end
  end

  # Generating routes for all Post types and their tags.
  Post.types.each do |type|
    parse_and_define_routes_for type, "#{root}/#{type.pluralized_type_s}/*.md"
    define_tag_routes_for type
  end

  authors.uniq!

  # Generating routes for every author. The response page will display a list of
  # articles written by that author.
  # e.g. /authors/radi
  authors.each do |author|
    get "/authors/#{author}" do
      articles = Article.by_author author
      erb :index, :locals => { :posts => articles }
    end
  end

  # Index routes for different posts
  %w(/ /articles).each do |route|
    get route do
      erb :index
    end
  end

  get '/recipes' do
    erb :index, :locals => { :posts => Recipe.all }
  end

  get '/notes' do
    erb :index, :locals => { :posts => Note.all }
  end


  not_found do
    erb :'404'
  end

  helpers do
    # Converts a TagList to a comma separated string with the tags replaced
    # by a link pointing to the tags path (tags/:tag_name).
    #
    # @example
    #   tags = TagList.new "ruby, rails"
    #
    #   # Probably in a view:
    #   linkified_tags tags
    #   # => "<a href=\"http://localhost:9393/articles/tags/ruby\">ruby</a>,
    #         <a href=\"http://localhost:9393/articles/tags/rails\">rails</a>"
    def linkified_tags(post)
      post.tags.to_a.map do |tag|
        link_to tag, "#{post.pluralized_type_s}/tags/#{tag}"
      end.join ', '
    end

    def link_to(body, source)
      %Q(<a href="#{url source}">#{body}</a>)
    end

    # Similar to Rails path helper for a show path of a resource. Does not
    # support namespaces or irregular plurals.
    def post_path(post)
      "/#{post.class.to_s.downcase}s/#{post.slug}"
    end

    def author_path(post)
      "/authors/#{post.author_slug}"
    end
  end
end
