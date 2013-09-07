require 'sinatra/base'

class HerokuHook < Sinatra::Base
  post '/update' do
    raise 'i got to the heroku hook'
  end
end
