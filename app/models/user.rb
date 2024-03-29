# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :topics, dependent: :destroy

  validates :username, presence: true, uniqueness: true

  before_validation :generate_username, on: :create

  broadcasts_refreshes

  friendly_id :username, use: :slugged

  def self.top_users(limit, min_topic_count)
    joins(:topics)
      .select('users.*, COUNT(topics.id) as topic_count')
      .group('users.id')
      .having('COUNT(topics.id) >= ?', min_topic_count)
      .order('topic_count DESC')
      .limit(limit)
  end

  private

  def generate_username
    self.username = SecureRandom.hex(6)
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  slug                   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
