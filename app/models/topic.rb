# frozen_string_literal: true

class Topic < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model

  belongs_to :user

  before_validation :remove_query_string
  validates :title, :hashtag, :x_link, presence: true
  validates :hashtag, format: { without: /\A#/, message: I18n.t('topics.validations.hashtag') }
  validates_with TweetUrlValidator, fields: [:x_link]

  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  pg_search_scope :search_by_title_x_link_and_hashtag,
                  against: %i[title hashtag x_link user_id], using: {
                    tsearch: { prefix: true }
                  }

  serialize :downvoted_user_ids, type: Array, coder: JSON

  def downvote!(user)
    if user_has_downvoted?(user)
      update(downvotes: downvotes - 1, downvoted_user_ids: downvoted_user_ids - [user.id])
    else
      update(downvotes: downvotes + 1, downvoted_user_ids: downvoted_user_ids << user.id)
    end
  end

  def user_has_downvoted?(user)
    downvoted_user_ids.include?(user.id)
  end

  private

  def remove_query_string
    return if x_link.blank?

    uri = URI.parse(x_link)
    uri.query = nil
    self.x_link = uri
  end
end
# == Schema Information
#
# Table name: topics
#
#  id                 :bigint           not null, primary key
#  downvoted_user_ids :text
#  downvotes          :integer          default(0), not null
#  hashtag            :string           not null
#  slug               :string
#  title              :string           not null
#  x_link             :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null
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
