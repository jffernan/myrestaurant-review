class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :content
      t.string :cuisine
      t.string :rating
      t.integer :user_id
      t.integer :restaurant_id
    end
  end
end
