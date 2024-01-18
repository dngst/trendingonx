# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    title { Faker::Lorem.sentence }
    x_link { 'https://twitter.com/X/status/1716896883434799556' }
    hashtag { Faker::Lorem.word }
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
