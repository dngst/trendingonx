# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic do
  pending "add some examples to (or delete) #{__FILE__}"
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