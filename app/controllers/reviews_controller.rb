class ReviewsController < ApplicationController
  get '/reviews' do
    erb :'reviews/reviews'
  end

end
