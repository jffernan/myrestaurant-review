class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "restaurantreview"
  end

  helpers do
    
  end

  get '/' do
    "Testing!"
  end

end
