class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  def self.alphabetical_order
    Review.order(rest_name: :asc)
  end

end
