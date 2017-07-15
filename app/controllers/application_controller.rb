require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "restaurantreview"
  end

  get '/' do
    erb :index
  end
=begin

    def logged_in?
      !!current_user
    end

    get '/' do
    def current_user
      @current_user ||= User.find_by(id:session[user:id]) if session[user_id]
    end
  end
=end
end
