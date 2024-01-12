# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'topics/new' do
  before do
    assign(:topic, Topic.new(
                     title: 'MyString',
                     x_link: 'MyString',
                     hashtag: 'MyString',
                     user: nil
                   ))
  end

  it 'renders new topic form' do
    render

    assert_select 'form[action=?][method=?]', topics_path, 'post' do
      assert_select 'input[name=?]', 'topic[title]'

      assert_select 'input[name=?]', 'topic[x_link]'

      assert_select 'input[name=?]', 'topic[hashtag]'

      assert_select 'input[name=?]', 'topic[user_id]'
    end
  end
end
