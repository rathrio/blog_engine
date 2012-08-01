require 'sinatra/base'
require 'article_parser'
require 'github_hook'
require 'rdiscount'

class Blog < Sinatra::Base
  use GithubHook if settings.production?
  
  extend ArticleParser
  
  set :root, File.expand_path('../../', __FILE__)
  set :articles, []
  
  Dir.glob "#{root}/articles/*.md" do |file|
    article = file_to_article file
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