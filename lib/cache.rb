require 'sinatra/base'
require 'time'

class Cache < Sinatra::Base
  set :deployment_date, Time.now

  before do
    cache_control :public, :must_revalidate
    last_modified settings.deployment_date
  end
end
