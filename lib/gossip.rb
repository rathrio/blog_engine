require 'sinatra/base'
require 'sinatra/streaming'

class Gossip < Sinatra::Base
  helpers Sinatra::Streaming

  set :root, File.expand_path('../../', __FILE__)
  set :connections, []

  get '/' do
    halt erb(:'gossip/login') unless params[:user]
    erb :'gossip/index', :locals => { :user => params[:user].gsub(/\W/, '') }
  end

  get '/stream', :provides => "text/event-stream" do
    stream :keep_open do |out|
      settings.connections << out
      out.callback { settings.connections.delete out }
    end
  end

  post '/' do
    settings.connections.each { |out| out << "data: #{params[:msg]}\n\n" }
    204
  end
end
