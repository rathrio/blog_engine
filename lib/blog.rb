require 'sinatra/base'
require 'article'
require 'html_with_pygments'
require 'cache'

class Blog < Sinatra::Base
  use Cache if production?

  configure :production, :development do
    enable :logging
  end

  set :root, File.expand_path('../../', __FILE__)
  set :articles,      []
  set :wip_articles,  []
  set :authors,       []
  set :tags,          []
  set :markdown, :renderer => HTMLwithPygments,
    :fenced_code_blocks => true, :layout_engine => :erb

  # Processes all markdown articles from given path and adds them to the given
  # articles array.
  def self.load_into(articles, path)
    Dir.glob path do |filename|
      article = Article.from_file filename
      articles << article
      authors  << article.author_slug
      tags.push *article.tags.to_a

      # Generating routes for single articles.
      # e.g. /articles/how_i_met_fuetzgue
      get "/articles/#{article.slug}" do
        erb :post, :locals => { :article => article }
      end
    end

    articles.sort_by! { |article| article.date }
    articles.reverse!
  end

  load_into articles, "#{root}/articles/*.md"
  load_into wip_articles, "#{root}/articles/wip/*.md"
  authors.uniq!
  tags.uniq!

  # Generating routes for every author. The respone page will display a list of
  # articles written by that author.
  # e.g. /authors/radi
  authors.each do |author|
    get "/authors/#{author}" do
      articles = settings.articles.select { |a| a.author == author }
      erb :index, :locals => { :articles => articles }
    end
  end

  # Generating routes for every tag. The respone page will display a list of
  # articles tagged with that tag.
  # e.g. /tags/english
  tags.each do |tag|
    get "/tags/#{tag}" do
      articles = settings.articles.select { |a| a.tags.to_a.include? tag }
      erb :index, :locals => { :articles => articles }
    end
  end

  get '/' do
    erb :index
  end

  # Generates a Work In Progress route. All articles that are placed in the
  # wip/ directory will show up on this page.
  get '/wip' do
    erb :index, :locals => { :articles => settings.wip_articles }
  end

  not_found do
    erb :'404'
  end

  helpers do
    # Converts a TagList to a comma separated string with the tags replaced
    # by a link pointing to the tags path.
    #
    # @example
    #   tags = TagList.new "ruby, rails"
    #
    #   # Probably in a view:
    #   linkified_tags tags
    #   #=> "<a href=\"http://localhost:9393/tags/ruby\">ruby</a>,
    #        <a href=\"http://localhost:9393/tags/rails\">rails</a>"
    def linkified_tags(tags)
      tags.to_a.map do |tag|
        tag_path = url("tags/#{tag}")
        bla = %Q(<a href="#{tag_path}">#{tag}</a>)
      end.join ', '
    end
  end
end
