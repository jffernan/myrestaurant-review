class UsersController < ApplicationController
  get '/users/:slug' do #SLUG IN USER.RB
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/reviews' #to reviews controller
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" #if user inputs empty back to signup
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])  #hash (params[:mode])
      @user.save
      session[:user_id] = @user.id #set session for user by user id
      redirect to '/reviews' #to reviews controller
    end
  end

end
