# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :user
  validates :title, :hashtag, :x_link, presence: true

  def extract_tweet_id_from_url(tweet_url)
    match_data = tweet_url.match(%r{twitter\.com/\w+/status/(\d+)})

    return unless match_data

    match_data[1]
  end
end

# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  hashtag    :string
#  title      :string
#  x_link     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_topics_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
