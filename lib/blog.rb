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

  # Posts
  set :articles, []
  set :notes,    []
  set :recipes,  []

  set :authors,  []
  set :tags,     []
  set :markdown, :renderer => HTMLwithPygments,
    :fenced_code_blocks => true, :layout_engine => :erb

  # Similar to Rails path helper for a show path of a resource. Does not
  # support namespaces or irregular plurals.
  def self.post_path(post)
    "/#{post.class.to_s.downcase}s/#{post.slug}"
  end

  def self.load_into(what, path)
    post_class = Object.const_get what.to_s.chop.capitalize
    storage = send(what)

    Dir.glob path do |filename|
      post = post_class.from_file filename
      storage << post
      authors << post.author_slug
      tags.push *post.tags.to_a

      # Generating routes for single post.
      # e.g. /articles/how_i_met_fuetzgue
      get post_path(post) do
        erb :post, :locals => { :post => post }
      end
    end

  end

  load_into :articles, "#{root}/articles/*.md"
  load_into :notes,    "#{root}/notes/*.md"
  load_into :recipes,  "#{root}/recipes/*.md"

  authors.uniq!
  tags.uniq!

  # Generating routes for every author. The respone page will display a list of
  # articles written by that author.
  # e.g. /authors/radi
  authors.each do |author|
    get "/authors/#{author}" do
      articles = settings.articles.select { |a| a.author == author }
      erb :index, :locals => { :posts => articles }
    end
  end

  # Generating routes for every tag. The respone page will display a list of
  # articles tagged with that tag.
  # e.g. /tags/english
  tags.each do |tag|
    get "/tags/#{tag}" do
      articles = settings.articles.select { |a| a.tags.to_a.include? tag }
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
    erb :index, :locals => { :posts => settings.recipes }
  end

  get '/notes' do
    erb :index, :locals => { :posts => settings.notes }
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
    #   # => "<a href=\"http://localhost:9393/tags/ruby\">ruby</a>,
    #         <a href=\"http://localhost:9393/tags/rails\">rails</a>"
    def linkified_tags(tags)
      tags.to_a.map do |tag|
        tag_path = url("tags/#{tag}")
        %Q(<a href="#{tag_path}">#{tag}</a>)
      end.join ', '
    end

    def post_path(post)
      Blog.post_path post
    end

  end
end
