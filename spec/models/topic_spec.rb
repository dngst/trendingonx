# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic do
  let(:user) { create(:user) }
  let(:ruby_topic) { create(:topic, title: 'Ruby on Rails', hashtag: 'programming', x_link: 'https://twitter.com/rails/status/1747065669487624601', user:) }
  let(:react_topic) { create(:topic, title: 'React', hashtag: 'javascript', x_link: 'https://twitter.com/react/status/1747065669487624601', user:) }
  let(:python_topic) { create(:topic, title: 'Python', hashtag: 'programming', x_link: 'https://twitter.com/python/status/1747065669487624601', user:) }

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

  describe '#downvote!' do
    let!(:topic) { create(:topic, user:) }

    it 'increases downvotes count if user has not downvoted' do
      expect { topic.downvote!(user) }.to change { topic.reload.downvotes }.by(1)
    end

    it 'decreases downvotes count if user has already downvoted' do
      topic.update(downvotes: 5, downvoted_user_ids: [user.id])
      expect { topic.downvote!(user) }.to change { topic.reload.downvotes }.by(-1)
    end

    it 'increases downvotes count for different users' do
      another_user = create(:user)
      expect { topic.downvote!(another_user) }.to change { topic.reload.downvotes }.by(1)
    end
  end

  describe '.search' do
    it 'returns topics that match the query' do
      results = described_class.search('programming')
      expect(results).to include(ruby_topic, python_topic)
      expect(results).not_to include(react_topic)
    end

    it 'is case-insensitive' do
      results = described_class.search('ruby')
      expect(results).to include(ruby_topic)
      expect(results).not_to include(react_topic, python_topic)
    end

    it 'returns an empty array if no topics match the query' do
      results = described_class.search('perl')
      expect(results).to be_empty
    end
  end

  describe '#remove_query_string' do
    let!(:topic) { create(:topic, x_link: 'https://twitter.com/rails/status/1747065669487624601?s=20', user:) }

    it 'removes the query string from the x_link' do
      expect(topic.x_link).to eq('https://twitter.com/rails/status/1747065669487624601')
    end
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
