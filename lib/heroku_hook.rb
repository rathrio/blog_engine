require 'sinatra/base'

class HerokuHook < Sinatra::Base
  before do
    cache_control :public, :must_revalidate
    last_modified Time.now
  end
end
