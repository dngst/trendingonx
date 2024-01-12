# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'topics/edit' do
  let(:topic) do
    Topic.create!(
      title: 'MyString',
      x_link: 'MyString',
      hashtag: 'MyString',
      user: nil
    )
  end

  before do
    assign(:topic, topic)
  end

  it 'renders the edit topic form' do
    render

    assert_select 'form[action=?][method=?]', topic_path(topic), 'post' do
      assert_select 'input[name=?]', 'topic[title]'

      assert_select 'input[name=?]', 'topic[x_link]'

      assert_select 'input[name=?]', 'topic[hashtag]'

      assert_select 'input[name=?]', 'topic[user_id]'
    end
  end
end
