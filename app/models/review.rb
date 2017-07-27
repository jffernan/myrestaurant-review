class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  def self.alphabetical_order #ActiveRecord method to alphabetize lists
    Review.order(rest_name: :asc)
  end

end
