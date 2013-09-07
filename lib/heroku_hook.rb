require 'sinatra/base'

class HerokuHook < Sinatra::Base
  def self.deployed
    set(:last_deployed) { Time.now }
  end

  deployed

  before do
    cache_control :public, :must_revalidate
    last_modified settings.last_deployed
  end

  post '/update' do
    settings.deployed
  end
end
