require 'sinatra/base'

class Cache < Sinatra::Base
  post '/update' do
    raise params.inspect
  end
end
