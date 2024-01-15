# frozen_string_literal: true

class Topic < ApplicationRecord
  extend FriendlyId
  serialize :downvoted_user_ids, Array, coder: JSON

  belongs_to :user
  validates :title, :hashtag, :x_link, presence: true

  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  def downvote!(user)
    return if user_has_downvoted?(user)

    update(downvotes: downvotes + 1, downvoted_user_ids: downvoted_user_ids << user.id)
  end

  def user_has_downvoted?(user)
    downvoted_user_ids.include?(user.id)
  end
end
# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  downvotes  :integer          default(0), not null
#  hashtag    :string
#  slug       :string
#  title      :string
#  x_link     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_topics_on_slug     (slug) UNIQUE
#  index_topics_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
