class AddDownvotesToTopic < ActiveRecord::Migration[7.1]
  def change
    add_column :topics, :downvotes, :integer, default: 0, null: false
  end
end
