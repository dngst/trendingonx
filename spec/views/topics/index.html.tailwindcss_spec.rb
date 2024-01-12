# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'topics/index' do
  before do
    assign(:topics, [
             Topic.create!(
               title: 'Title',
               x_link: 'X Link',
               hashtag: 'Hashtag',
               user: nil
             ),
             Topic.create!(
               title: 'Title',
               x_link: 'X Link',
               hashtag: 'Hashtag',
               user: nil
             )
           ])
  end

  it 'renders a list of topics' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Title'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('X Link'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Hashtag'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
