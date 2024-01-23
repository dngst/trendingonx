# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :x_link }
  it { is_expected.to validate_presence_of :hashtag }
  it { is_expected.to belong_to :user }
  it { is_expected.not_to allow_value('#hashtag').for(:hashtag) }
  it { is_expected.not_to allow_value('plainstring').for(:x_link) }
  it { is_expected.not_to allow_value('https://twitter.com/CatWorkers').for(:x_link) }
  it { is_expected.not_to allow_value('https://x.com/CatWorkers').for(:x_link) }
  it { is_expected.to allow_value('https://twitter.com/CatWorkers/status/1747065669487624601').for(:x_link) }
  it { is_expected.to allow_value('https://x.com/CatWorkers/status/1747065669487624601').for(:x_link) }
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
