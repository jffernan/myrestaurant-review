class UsersController < ApplicationController
  get '/users/:slug' do #SLUG IN USER.RB
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/reviews'
    end
  end

end
