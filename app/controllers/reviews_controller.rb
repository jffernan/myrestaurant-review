class ReviewsController < ApplicationController
  get '/reviews' do
    erb :'reviews/reviews'
  end

  get '/reviews/new' do
    erb :'reviews/new'
  end

  #if statement for empty input to refresh
=begin
  post '/reviews' do
    @review = Review.new(:some_attribute params[:some_attribute])  #or (params[:mode])
    @review.save
    redirect to '/reviews/#{@review.id}'
  end

  get '/reviews' do
     @reviews = Review.all
     erb :'reviews/all'
   end

   get '/reviews/:id' do
     @review = Review.find(params[:id])
     erb :'reviews/show'
   end 

   get '/reviews/:id/edit' do
     @review = Review.find(params[:id])
     erb :'reviews/edit'
   end

   post '/reviews/:id' do	#PATCH use Rack::MethodOverride
     @review = Review.find(params[:id])
     @review.update(some_attribute: params[:some_attribute])
     @review.save
     redirect to '/reviews/#{@review.id}'
   end

   post '/reviews/:id/delete'#DELETE need HIDDEN button erb
     @review = Review.find(params[:id])
     @review.destroy
      redirect to '/reviews/#{@review.id}'
   end
=end
  end
