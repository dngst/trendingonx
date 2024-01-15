# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    title { 'MyString' }
    x_link { 'MyString' }
    hashtag { 'MyString' }
    user { nil }
  end
end

# == Schema Information
#
# Table name: topics
#
#  id                 :bigint           not null, primary key
#  downvoted_user_ids :text
#  downvotes          :integer          default(0), not null
#  hashtag            :string
#  slug               :string
#  title              :string
#  x_link             :string
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
