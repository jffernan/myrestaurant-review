class UsersController < ApplicationController
  get '/users/:slug' do #SLUG IN USER.RB
    @user = User.find_by_slug(params[:slug])
    erb :'users/welcome'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      erb :'users/welcome'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty? #if user inputs empty back to signup
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])  #hash (params[:mode])
      @user.save
      session[:user_id] = @user.id #set session for user by user id
      erb :'users/welcome'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(:username => params[:username]) #local variable to find if there is a user and match or not
    if user && user.authenticate(params[:password]) #using method from bcrypt gemt
      session[:user_id] = user.id #set session for user by user id
      redirect to '/reviews' #to reviews controller
    else
      redirect to '/error' #if not a user and password not match, display error msg
    end
  end

  get '/error' do
    erb :'users/error'
  end

  get '/logout' do
    if logged_in?
  		session.clear
      redirect to '/login'
    else
  		redirect to '/'
    end
  end

end
