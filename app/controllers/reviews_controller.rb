class ReviewsController < ApplicationController

  get '/reviews' do
    if logged_in?
      @reviews = current_user.reviews.all #show only logged_in CURRENT user's reviews
      #@reviews = @reviews.sort{|a,b| a['rest_name'] <=> b['rest_name']} #alphabetize list
      @reviews = @reviews.alphabetical_order #defined ActiveRecord method in model.rb
      erb :'reviews/reviews' #SELECT rest_name FROM reviews ORDER BY rest_name ASC;
    else
      redirect to '/login' #Review.order(rest_name: :asc)
    end
  end

  get '/reviews/all' do
    if logged_in?
      @reviews = Review.all #show all reviews by users
      #@reviews = @reviews.sort{|a,b| a['rest_name'] <=> b['rest_name']} #alphabetize list
      @reviews = @reviews.alphabetical_order #defined ActiveRecord method in model.rb
      erb :'reviews/all'
    else
      redirect to '/login'
    end
  end

  get '/reviews/restaurants' do
    if logged_in?
      @reviews = Review.all #show all reviews by users
      @reviews = @reviews.alphabetical_order #defined ActiveRecord method in model.rb
      erb :'reviews/restaurants'
    else
      redirect to '/login'
    end
  end

  get '/reviews/new' do
    if logged_in?
      erb :'reviews/new'
    else
      redirect to '/login'
    end
  end

  post '/reviews' do
    if params[:rest_name].empty? || #If to test if user enters inputs
      params[:content].empty? ||
      params[:cuisine].empty? ||
      params[:rating] == ""
      redirect to '/reviews/new'
    end
    @review = Review.new(
    rest_name: params[:rest_name],
    content: params[:content],
    cuisine: params[:cuisine],
    rating: params[:rating],
    user_id: current_user.id)
    @review.save
    redirect to "/reviews/#{@review.id}"
  end

   get '/reviews/:id' do
     if logged_in?
       @review = Review.find_by_id(params[:id])
       erb :'reviews/show'
     else
       redirect to '/login'
     end
   end

get '/reviews/:id/edit' do
  if logged_in?
    @review = Review.find_by_id(params[:id])
    if @review && @review.user_id == current_user.id
      erb :'reviews/edit'
    else
      redirect to "/reviews/#{params[:id]}" #Test user can't edit another user review
    end
  else
    redirect to '/login'
  end
end

   patch '/reviews/:id' do	#PATCH use Rack::MethodOverride
     if params[:rest_name].empty? || params[:content].empty? || params[:cuisine].empty? || params[:rating] == ""
        redirect to "/reviews/#{params[:id]}/edit"
     end
     @review = Review.find_by_id(params[:id])
        if @review && @review.user_id == current_user.id #Validate User if this his review
          @review.update(rest_name: params[:rest_name])
          @review.update(content: params[:content])
          @review.update(cuisine: params[:cuisine])
          @review.update(rating: params[:rating])
          @review.save
          redirect to "/reviews/#{params[:id]}" #show new edit(s)
        end
    end

    delete '/reviews/:id/delete' do#DELETE need HIDDEN button erb
      if logged_in?
        @review = Review.find_by_id(params[:id])
        if @review.user_id == current_user.id #validate if user owns this review or not?
          @review.delete
          redirect to '/reviews' #go back to user list of reviews
        else
          redirect to "/reviews/#{params[:id]}" #Test user can't delete another user review
        end
      else
        redirect to '/login'
      end
    end
end
