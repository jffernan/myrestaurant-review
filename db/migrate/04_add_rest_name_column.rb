class AddRestNameColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :rest_name, :string
  end
end
