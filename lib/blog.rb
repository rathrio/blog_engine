require 'sinatra/base'
require 'article'
require 'html_with_pygments'

class Blog < Sinatra::Base
  configure :production, :development do
    enable :logging
  end

  set :root, File.expand_path('../../', __FILE__)
  set :articles, []
  set :markdown, :renderer => HTMLwithPygments,
    :fenced_code_blocks => true, :layout_engine => :erb

  Dir.glob "#{root}/articles/*.md" do |filename|
    article = Article.from_file filename
    articles << article

    get "/articles/#{article.slug}" do
      erb :post, :locals => { :article => article }
    end
  end

  articles.sort_by! { |article| article.date }
  articles.reverse!

  get '/' do
    erb :index
  end
end
