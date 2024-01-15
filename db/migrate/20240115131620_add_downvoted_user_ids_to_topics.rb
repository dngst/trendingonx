class AddDownvotedUserIdsToTopics < ActiveRecord::Migration[7.1]
  def change
    add_column :topics, :downvoted_user_ids, :text
  end
end
