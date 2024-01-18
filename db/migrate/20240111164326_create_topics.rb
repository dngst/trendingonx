class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.string :x_link, null: false
      t.string :hashtag, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
