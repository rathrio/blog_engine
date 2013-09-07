require 'sinatra/base'

# Not in use as long as blog is hosted on heroku.
class GithubHook < Sinatra::Base
  set(:autopull) { production? }

  post '/update' do
    app.settings.reset!
    load app.settings.app_file

    content_type :txt
    if settings.autopull?
      `git submodule update`
    else
      "ok"
    end
  end
end
