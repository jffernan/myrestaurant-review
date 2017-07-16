class ReviewsController < ApplicationController
  get '/reviews' do
    if logged_in?
      @reviews = Review.all
      erb :'reviews/reviews'
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
    if params[:rest_name].empty? || params[:content].empty? || params[:cuisine].empty? || params[:rating].empty?
      redirect to '/reviews/new'
    else
      @review = Review.new(rest_name: params[:rest_name], content:params[:content], cuisine: params[:cuisine], rating: params[:rating], user_id:current_user.id)
      @review.save
      redirect to '/reviews/#{@review.id}'
    end
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
     if !logged_in?
       redirect to '/login'
     end
       @review = Review.find_by_id(params[:id])
       if @review && @review.user_id == current_user.id
         erb :'reviews/edit'
       else
         redirect to '/login'
       end
   end

   patch '/reviews/:id' do	#PATCH use Rack::MethodOverride
     if params[:rest_name].empty? || params[:content].empty?#Test rest_name, cuisine, rating
        redirect to '/reviews/#{params[:id]}/edit'
     end
     @review = Review.find(params[:id])
        if @review && @review.user_id == current_user.id #Validate User if this his review
          @review.update(rest_name: params[:rest_name])
          @review.update(content: params[:content])
          @review.save
          redirect to '/reviews'
        end
    end

    post '/reviews/:id/delete'#DELETE need HIDDEN button erb
      if logged_in?
        @review = Review.find_by_id(params[:id])
        if @review.user_id == current_user.id #validate if user owns this review or not?
          @review.delete
          redirect to '/reviews'
        else
          redirect to '/reviews'
        end
      else
        redirect to '/login'
      end
    end

end
