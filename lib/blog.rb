require 'sinatra/base'
require 'article_parser'
require 'glorify'

class Blog < Sinatra::Base
  include ArticleParser

  register Sinatra::Glorify

  configure :production, :development do
    enable :logging
  end

  set :root, File.expand_path('../../', __FILE__)
  set :articles, []

  Dir.glob "#{root}/articles/*.md" do |filename|
    article = file_to_article filename
    articles << article

    get "/#{article.slug}" do
      erb :post, :locals => { :article => article }
    end
  end

  articles.sort_by! { |article| article.date }
  articles.reverse!

  get '/' do
    erb :index
  end
end
