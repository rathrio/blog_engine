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
  set :articles,     []
  set :wip_articles, []
  set :archive,      []
  set :markdown, :renderer => HTMLwithPygments,
    :fenced_code_blocks => true, :layout_engine => :erb

  def self.load_into(articles, path)
    Dir.glob path do |filename|
      article = Article.from_file filename
      articles << article

      get "/articles/#{article.slug}" do
        erb :post, :locals => { :article => article }
      end
    end

    articles.sort_by! { |article| article.date }
    articles.reverse!
  end

  load_into articles, "#{root}/articles/*.md"
  load_into wip_articles, "#{root}/articles/wip/*.md"

  get '/' do
    erb :index
  end

  get '/wip' do
    erb :index, :locals => { :articles => settings.wip_articles }
  end

  not_found do
    erb :'404'
  end
end
