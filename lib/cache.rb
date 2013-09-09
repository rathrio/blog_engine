require 'sinatra/base'
require 'time'

# The Cache middleware sets the last modified header to the date of the most
# recent deployment.
# Since this blog is a webapp with mostly static pages, we don't want to process
# the request every single time. One can assume that the content only changes
# with a deployment.
class Cache < Sinatra::Base
  set :deployment_date, Time.now

  before do
    cache_control :public, :must_revalidate
    last_modified settings.deployment_date
  end
end
