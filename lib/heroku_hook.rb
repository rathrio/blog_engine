require 'sinatra/base'

class HerokuHook < Sinatra::Base
  before do
    cache_control :public, :must_revalidate
    # test
    etag 3
  end
end
